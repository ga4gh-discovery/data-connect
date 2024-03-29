---
title: "Provision Data"
weight: 3
draft: false
lastmod: 2021-11-29
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

[Example Use Cases](/docs/use-existing-data/)
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

Use the following instructions to run a reference [Data Connect implementation](https://github.com/DNAstack/data-connect-trino) backed by a publicly accessible Trino instance hosted by DNAstack as the data source.

You’ll need Docker set up on your system to run the Spring app and the PostgreSQL database where it stores information about running queries.
{divider}
{{<code/float-window>}}
{{< tabs tabTotal="2" tabID="2" tabName1="MacOS and Windows" tabName2="Linux">}}
{{% tab tabNum="1" %}}
``` bash
docker pull postgres:latest
docker run -d --rm --name dnastack-data-connect-db -e POSTGRES_USER=dataconnecttrino -e POSTGRES_PASSWORD=dataconnecttrino -p 15432:5432 postgres
docker pull dnastack/data-connect-trino:latest
docker run --rm --name dnastack-data-connect -p 8089:8089 -e TRINO_DATASOURCE_URL=https://trino.faux.dnastack.com -e SPRING_DATASOURCE_URL=jdbc:postgresql://host.docker.internal:15432/dataconnecttrino -e SPRING_PROFILES_ACTIVE=no-auth dnastack/data-connect-trino
```
{{% /tab %}}
{{% tab tabNum="2" %}}
``` bash
docker pull postgres:latest
docker run -d --rm --name dnastack-data-connect-db -e POSTGRES_USER=dataconnecttrino -e POSTGRES_PASSWORD=dataconnecttrino -p 15432:5432 postgres
docker pull dnastack/data-connect-trino:latest
docker run --rm --name dnastack-data-connect -p 8089:8089 -e TRINO_DATASOURCE_URL=https://trino.faux.dnastack.com -e SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:15432/dataconnecttrino -e SPRING_PROFILES_ACTIVE=no-auth dnastack/data-connect-trino
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}

{row-divider}

Once you have the Data Connect implementation running, the Data Connect API will be accessible at [http://localhost:8089](http://localhost:8089). Here are a few things to try:

1. Open [http://localhost:8089/tables](http://localhost:8089/tables) in your web browser to see the table list API response. It helps if you have a browser plugin that pretty-prints JSON.
2. Try the Python, R, and CLI examples at right. These examples access Data Connect at http://localhost:8089. See the [Installing Clients](/docs/getting-started/clients/) section if you haven't set up the clients yet.
3. Set up your own Trino instance, then re-run the dnastack-data-connect container with the `TRINO_DATASOURCE_URL` pointed to your own Trino instance.

Further information about this example can be found [here](/docs/use-existing-data/using-trino/doc/).
{divider}
{{<code/float-window>}}
{{< tabs tabTotal="3" tabID="3" tabName1="Python" tabName2="R" tabName3="CLI">}}
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
table_name = "collections.public_datasets.sample_phenopackets_gecco_phenopackets"
table_info = search_client.get_table_info(table_name)
print(table_info)
```
``` python
# get table data
table_name = "collections.public_datasets.sample_phenopackets_gecco_phenopackets"
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
search_result <- ga4gh.search::ga4gh_search("http://localhost:8089", "SELECT * FROM collections.public_datasets.sample_phenopackets_gecco_phenopackets")
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
search-cli info collections.public_datasets.dbgap_scr_gecco_susceptibility_sample_multi --api-url http://localhost:8089
```
Get table data
``` bash
search-cli data collections.public_datasets.dbgap_scr_gecco_susceptibility_sample_multi --api-url http://localhost:8089
```
{{% /tab %}}

{{< /tabs >}}
{{</code/float-window>}}

