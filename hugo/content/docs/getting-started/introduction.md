---
title: "Introduction"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: two-col
---
{row-divider}
### The GA4GH Search API
The GA4GH Search API specification describes a simple, uniform mechanism to publish, discover, query, and analyze biomedical data. Any “rectangular” data that fits into rows and columns can be represented by GA4GH Search. 

#### Search API for data custodians
Search API is a perfect solution for data custodians looking to make their biomedical data discoverable and searchable. 
- The API is minimalistic by design, which also means minimal resistance to adoption.
- Search does not prescribe a particular data model. If it fits into rows and columns, you can publish it.
- Search serves as a general-purpose framework for building federative search-based applications across multiple implementations.
- Search is backend agnostic. It is possible to implement the API across a large variety of backend datastores.

#### Search API for data consumers
Search API is a perfect solution for data consumers looking to discover and search biomedical data in an interoperable way.
- Search API is RESTful. Read our Open API 3 specification.
- Search API is discoverable and browsable. [See supported table operations](https://github.com/ga4gh-discovery/ga4gh-search/blob/develop/SEARCHSPEC.md#discovery-and-browsing)
- Search API is queryable and familiar. Search API's SQL dialect has a familiar interface inspired by current major open source database platforms.

{divider}
{{<code/float-window>}}
{{%content-textbox%}}
##### Quick Links
---
[Full API Specifications](/api)

[Installing Client Libraries](/docs/getting-started/clients/)

[Publishing Data Examples](/docs/getting-started/provision-data/)

[Data Consumption Examples](/docs/getting-started/consume-data/)
{{%/content-textbox%}}
{{</code/float-window>}}