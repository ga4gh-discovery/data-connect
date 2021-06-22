---
title: "Pagination and Long Running Queries"
weight: 1
draft: false
lastmod: 2020-12-3
type: docs
layout: single-col
---
**Pagination Sequence**

A pagination sequence is the singly-linked list of URLs formed by following the `next_page_url` property of the pagination section of an initial `TableData` or `ListTablesResponse`. A pagination sequence begins at the first response returned from any request that yields a `TableData` or `ListTablesResponse`, and ends at the page in the sequence whose pagination property is omitted, whose `pagination.next_page_url` is omitted, or whose `pagination.next_page_url` is `null`.

Servers **may** return a unique pagination sequence in response to successive requests for the same query, table data listing, or table listing.

Except for the last page, `pagination.next_page_url property` **must** be either an absolute URL or a relative reference as defined by [RFC 3986 section 4.2](https://tools.ietf.org/html/rfc3986#section-4.2) whose base URL is the URL that the page containing the reference was fetched from.

Every non-empty `TableData` page in a pagination sequence **must** include a `data_model` property. If present, the `data_model` property `must` be a valid JSON Schema.

Across all `TableData` pages in the pagination sequence that have a `data_model` value, the `data_models` **must** be identical. Some `TableData` pages may lack a `data_model`. See the empty page rules below.

Servers **may** respond with an `HTTP 4xx` error code if the same page is requested more than once.

Due to both rules above, clients **must not** rely on the ability to re-fetch previously encountered pages.

Servers **may** include a Retry-After HTTP header in each response that is part of a pagination sequence, and clients **must** respect the delay specified by such header before attempting to fetch the next page.

**Empty TableData Pages**

While many types of queries will be completed quickly, others will take minutes or even hours to yield a result. The simplest solution would be a synchronous design: query requests block until data is ready, then return a `TableData` response with the initial rows of the result set. However, asking clients to block for hours on a single HTTP response is fraught with difficulty: open connections are costly and fragile. If an intermediary times out the request, the results will be lost and the client must start over.

To allow servers to direct clients to poll for results rather than hold open HTTP connections for long-running queries, the following special pagination rules apply to empty pages.

An empty page is defined as a `TableData` object whose data property is a zero element array.

A pagination sequence MAY include any number of empty pages anywhere in the sequence.

An empty `TableData` page **may** omit its data_model property entirely. This allows servers to direct clients to poll for results before the result schema has been determined.

A server that returns an empty page **should** include a `Retry-After` header in the HTTP response. If a client encounters an empty page with no `Retry-After` header, the client **should** delay at least 1 second before requesting the next page.

**Example: Server returning empty pages to make client poll**

This example illustrates a server returning a series of empty pages to a client while it is preparing the result set. The client polls for results by following `next_page_url` at the rate specified by the server. The form of the pagination URLs are only an example of one possible scheme. Servers are free to employ any pagination URL scheme.

**Initial Request**


```json
POST /search
content-type: application/json

{"query":"select distinct gene_symbol from example_project.brca_exchange.v32"}

HTTP/1.1 200 OK
content-type: application/json
retry-after: 1000

{"data":[],"pagination":{"next_page_url":"/search/v1/statement/abc123/queued/1"}}
```


**2nd request (Polling after sleeping for 1000ms)**


```json
GET /search/v1/statement/abc123/queued/1

HTTP/1.1 200 OK
content-type: application/json
retry-after: 1000

{"data":[],"pagination":{"next_page_url":"/search/v1/statement/abc123/queued/2"}}
```


**3rd request (Polling again after sleeping for 1000ms)**


```json
GET /search/v1/statement/abc123/queued/2

HTTP/1.1 200 OK
content-type: application/json
retry-after: 1000

{"data":[],"pagination":{"next_page_url":"/search/v1/statement/abc123/executing/1"}}
```


**4th request (Polling again after sleeping for 1000ms)**


```json
GET /search/v1/statement/abc123/executing/1

HTTP/1.1 200 OK
content-type: application/json

{"data_model":{"description":"Automatically generated schema","$schema":"http://json-schema.org/draft-07/schema#","properties":{"gene_symbol":{"format":"varchar","type":"string"}}},"data":[{"gene_symbol":"BRCA2"},{"gene_symbol":"BRCA1"}],"pagination":{"next_page_url":"/search/v1/statement/abc123/executing/2"}}
```


**Final request (no delay because page was nonempty and no retry-after header was present on the response)**


```json
GET /search/v1/statement/abc123/executing/2

HTTP/1.1 200 OK
content-type: application/json

{"data_model":{"description":"Automatically generated schema","$schema":"http://json-schema.org/draft-07/schema#","properties":{"gene_symbol":{"format":"varchar","type":"string"}}},"data":[],"pagination":{}}
```


**Example: Client algorithm for consuming TableData pages**

The algorithm provided here simply illustrates one way to comply with the rules above. Any algorithm that satisfies all rules acceptable.



1. Start with an empty data buffer and undefined data model.
2. Loop:
    1. If the response is an **error**, report the **error** and **abort**
    2. If no `data_model` has been seen so far, check if this page contains a `data_model`. If so, define the data model for the whole pagination sequence as this page’s `data_model`.
    3. Append the row data from the current page to the data buffer (there may be 0 rows on any given page)
    4. Delay for the time specified in the `Retry-After` HTTP response header for the current page (default is no delay)
    5. If there is a pagination object and it has a non-null `next_page_url`, fetch that URL, make that response the current page, and start back at step 2a; otherwise end.

