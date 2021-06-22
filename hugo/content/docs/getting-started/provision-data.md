---
title: "Provision Data"
weight: 3
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: two-col
---

{row-divider}
#### Implementation

Data Connect requires [table operations](/api/#tag/tables) to be implemented to specification for basic discovery and browsing. 

Optional but not required, [query operations](/api/#tag/search) may be implemented to support querying with SQL.

The Data Connect API is backend agnostic, which means any solution that implements the [API specification](/api) is valid. You can use your favorite backend web application framework to implement Data Connect Endpoints or any HTTPS file server (a cloud blob store, for example) for a tables-in-a-bucket implementation requiring no code.

Checkout the following examples for some inspiration.
{divider}
{{<code/float-window>}}
{{%content-textbox%}}
##### Quick Links
---
[Full API Specifications](/api)

[Example Use Cases](/docs/use-exisitng-data/)
{{%/content-textbox%}}
{{</code/float-window>}}
{row-divider}
#### Tables-in-a-bucket example
The specification allows for a no-code implementation as a collection of files served statically. This is the easiest way to start experimenting with Data Connect. As long as your storage bucket conforms to the correct file structure and it has the correct sharing permissions, it is a valid Data Connect implementation.

A concrete example implementation is [available here](https://storage.googleapis.com/ga4gh-tables-example/tables) and [try browsing this implementation](/docs/getting-started/consume-data/#browsing) with these commands.

{divider}
{{<code/float-window>}}
{{%content-textbox%}}
Here's how you'll need to organize your folders
- ```tables```: served in response to ```GET /tables```
- ```table/{table_name}/info```: served in response to ```GET /table/{table_name}/info```.  e.g. a table with the name ```mytable``` should have a corresponding file ```table/mytable/info```
- ```table/{table_name}/data```: served in response to ```GET /table/{table_name}/data```.  e.g. a table with the name ```mytable``` should have a corresponding file ```table/mytable/data```
- ```table/{table_name}/data_{pageNumber}```, which will be linked in the next_page_url of the first table  (e.g. ```mytable```).
- ```table/{table_name}/data_models/{schemaFile}```: Though not required, data models may be linked via [$ref](https://json-schema.org/latest/json-schema-core.html#rfc.section.8.3). Data models can also be stored as static JSON documents, and be referred to by relative or absolute URLs.
{{%/content-textbox%}}
{{</code/float-window>}}

{row-divider}
#### Try a Reference Implementation

This example was shown as a demo during the 2020 GA4GH Plenary. This app will run a reference Data Connect implementation on docker and use a Trino instance hosted by DNAstack as the data source.

You’ll need docker set up on your system to run the Spring app, and you’ll need to have one of the client libraries installed from the [Installing Clients Section](/docs/getting-started/clients/).

Further information about this example can be found [here](/docs/use-exisitng-data/using-preso/doc/).
{divider}
{{<code/float-window>}}
{{< tabs tabTotal="1" tabID="2" tabName1="30 second quick start">}}
{{% tab tabNum="1" %}}
``` bash
docker pull postgres:latest
docker run -d --rm --network="host" --name dnastack-ga4gh-search-db -e POSTGRES_USER=ga4ghsearchadapterpresto -e POSTGRES_PASSWORD=ga4ghsearchadapterpresto postgres
docker pull dnastack/ga4gh-search-adapter-presto:latest
docker run --rm --name dnastack-ga4gh-search -p 8089:8089 -e PRESTO_DATASOURCE_URL=https://presto-public.prod.dnastack.com -e SPRING_PROFILES_ACTIVE=no-auth dnastack/ga4gh-search-adapter-presto:latest
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}

{{<code/float-window>}}
{{< tabs tabTotal="3" tabID="2" tabName1="Python" tabName2="R" tabName3="CLI">}}
{{% tab tabNum="1" %}}
``` Python
# init search client
from search_python_client.search import DrsClient, SearchClient
base_url = 'http://localhost:8089/'
search_client = SearchClient(base_url=base_url)
```
``` python
# get tables
tables_iterator = search_client.get_table_list()
tables = [next(tables_iterator, None) for i in range(10)]
tables = list(filter(None, tables))
print(tables)
```
``` python
# get table info
table_name = "sample_phenopackets.ga4gh_tables.gecco_phenopackets"
table_info = search_client.get_table_info(table_name)
print(table_info)
```
``` python
# get table data
table_name = "sample_phenopackets.ga4gh_tables.gecco_phenopackets"
table_data_iterator = search_client.get_table_data(table_name)
table_data = [next(table_data_iterator, None) for i in range(10)]
table_data = list(filter(None, table_data))
print(table_data)
```
{{% /tab %}}
{{% tab tabNum="2" %}}
``` R
# Fetch table list
library(httr)
tables <- ga4gh.search::ga4gh_list_tables("http://localhost:8089")
print(tables)
```
``` R
# Try a query
search_result <- ga4gh.search::ga4gh_search("http://localhost:8089", "SELECT sample_phenopackets.ga4gh_tables.gecco_phenopackets")
print(tables)
```
{{% /tab %}}
{{% tab tabNum="3" %}}
List tables
``` bash
search-cli list --api-url http://localhost:8089
```
Get table info
``` bash
search-cli info dbgap_demo.scr_gecco_susceptibility.sample_multi --api-url http://localhost:8089
```
Get table data
``` bash
search-cli data dbgap_demo.scr_gecco_susceptibility.sample_multi --api-url http://localhost:8089
```
{{% /tab %}}

{{< /tabs >}}
{{</code/float-window>}}

