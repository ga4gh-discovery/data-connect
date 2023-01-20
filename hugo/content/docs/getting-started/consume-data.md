---
title: "Consume Data"
weight: 4
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: two-col
description: This section provides information about setting up Data Connect to expose data.
---
{row-divider}
#### Browsing
At minimum, Data Connect implementations support browsing by table. This means [these operations](/api/#tag/tables) from the API specs are supported for table by table browsing.

On the right is example code to browse [the tables-in-a-bucket](/docs/getting-started/provision-data/#tables-in-a-bucket-example) implementation of Data Connect.
{divider}
{{< tabs tabTotal="3" tabID="2" tabName1="Python" tabName2="R" tabName3="CLI">}}
{{% tab tabNum="1" %}}
[Follow along in Colab](https://colab.research.google.com/drive/1NytWLzQFWwGc3pqTaL0HD81S5B3zznLj?usp=sharing)
``` python
# init search client
import pandas as pd
from search_python_client.search import SearchClient
base_url_tiab = 'https://storage.googleapis.com/ga4gh-tables-example/'
search_client_tiab = SearchClient(base_url=base_url_tiab)
```
``` python
# get tables
tables_iterator = search_client_tiab.get_table_list()
tables = [next(tables_iterator, None) for i in range(10)]
tables = list(filter(None, tables))
pd.DataFrame(tables)
```
``` python
# get table info
table_name = tables[0]['name']
table_info = search_client_tiab.get_table_info(table_name)
print(table_info)
```
``` python
# get table data
table_name = tables[0]['name']
table_data_iterator = search_client_tiab.get_table_data(table_name)
table_data = [next(table_data_iterator, None) for i in range(10)]
table_data = list(filter(None, table_data))
pd.DataFrame(table_data)
```
{{% /tab %}}
{{% tab tabNum="2" %}}
```
Under construction
https://colab.research.google.com/drive/1VOP2IcPjsX4U-DfuiTs7Tr0SVlAD0IMh?usp=sharing <= doesn't work right now.
```
{{% /tab %}}
{{% tab tabNum="3" %}}
Get list of tables
``` bash
search-cli list --api-url https://storage.googleapis.com/ga4gh-tables-example
```
``` bash
search-cli info subjects --api-url https://storage.googleapis.com/ga4gh-tables-example
```
``` bash
search-cli data subjects --api-url https://storage.googleapis.com/ga4gh-tables-example
```
{{% /tab %}}

{{< /tabs >}}

{row-divider}
#### Queries

Data Connect supports query operation through SQL statements.

Data Connect's SQL dialect has a familiar interface inspired by current major open source database platforms, including Trino, PostgreSQL, MySQL, and BigQuery. If you have prior experience with these database platforms, you'll feel right at home with only minor adjustments.

[Supported SQL functions](https://github.com/ga4gh-discovery/data-connect/blob/develop/SPEC.md#sql-functions)

[Supported SQL grammar](https://github.com/ga4gh-discovery/data-connect/blob/develop/SPEC.md#appendix-a-sql-grammar)

{divider}
{{<code/float-window>}}
{{< tabs tabTotal="2" tabID="float" tabName1="Example #1" tabName2="Example #2">}}
{{% tab tabNum="1" %}}
This query returns all female patients from the `patient` table.
``` SQL
/* you can scroll on this tab */
SELECT *
FROM   collections.public_datasets.kidsfirst_patient
WHERE  Json_extract_scalar(patient, '$.gender') = 'female'
LIMIT  5;
```
{{% /tab %}}

{{% tab tabNum="2" %}}

This query returns all conditions observed in female patients from the `patient` table.
``` SQL
/* you can scroll on this tab */
SELECT Json_extract_scalar(ncpi_disease, '$.code.text')           AS disease,
       Json_extract_scalar(ncpi_disease, '$.identifier[0].value') AS identifier
FROM   collections.public_datasets.kidsfirst_ncpi_disease disease
       INNER JOIN collections.public_datasets.kidsfirst_patient patient
               ON patient.id = REPLACE(Json_extract_scalar(ncpi_disease,
                                       '$.subject.reference'),
                               'Patient/')
WHERE  Json_extract_scalar(patient, '$.gender') = 'female'
LIMIT  5;
```
<!-- FIXME Permission Issue -->
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}

{row-divider}

#### Issuing Queries Using Data Connect

Data Connect can be accessed through the straightforward HTTP calls described in its OpenAPI specification.

While Data Connect API can be navigated using programs like cURL or Postman, it is best accessed programmatically. The results could be split into multiple pages, which is easier to navigate with programmatic access.

Fetch each page only once. Data Connect servers are allowed to "forget" page URLs after you fetch them. This allows the server implementations to be more efficient.

On the right, we provide examples to consume data from Data Connect using the GA4GH Commandline Interface, the R client, Python, and cURL.

> [Need help installing client libraries?](/docs/getting-started/clients/)

{divider}
{{<code/float-window>}}
{{< tabs tabTotal="4" tabID="queries" tabName1="Python" tabName2="R" tabName3="CLI" tabName4="cURL">}}

{{% tab tabNum="1" %}}
[Follow Along in Google Colab](https://colab.research.google.com/drive/1efGB5O68_dtMgyqCeIjLG8ezMzDBBQj9?usp=sharing)
```bash
# Installing the client library form PyPi
pip install search-python-client
# Installing from Github
pip install git+https://github.com/DNAstack/search-python-client --no-cache-dir
```
```python
# Building the query
from search_python_client.search import SearchClient
base_url = 'https://data.publisher.dnastack.com/data-connect'
search_client = SearchClient(base_url=base_url)
query = """
SELECT Json_extract_scalar(ncpi_disease, '$.code.text')           AS disease,
       Json_extract_scalar(ncpi_disease, '$.identifier[0].value') AS identifier
FROM   collections.public_datasets.kidsfirst_ncpi_disease disease
       INNER JOIN collections.public_datasets.kidsfirst_patient patient
               ON patient.id = REPLACE(Json_extract_scalar(ncpi_disease,
                                       '$.subject.reference'),
                               'Patient/')
WHERE  Json_extract_scalar(patient, '$.gender') = 'female'
LIMIT  5
"""
```
```python
# Executing the query
table_data_iterator = search_client.search_table(query)
for item in table_data_iterator:
  print(item)
```
```python
# Results
{'disease': 'Aortic atresia', 'identifier': 'Condition|SD_PREASA7S|272|Aortic atresia|None'}
{'disease': 'Mitral atresia', 'identifier': 'Condition|SD_PREASA7S|272|Mitral atresia|None'}
{'disease': 'Hypoplasia ascending aorta', 'identifier': 'Condition|SD_PREASA7S|272|Hypoplasia ascending aorta|None'}
{'disease': 'Hypoplastic left heart syndrome', 'identifier': 'Condition|SD_PREASA7S|272|Hypoplastic left heart syndrome|None'}
{'disease': 'Hypoplastic left ventricle (subnormal cavity volume)', 'identifier': 'Condition|SD_PREASA7S|272|Hypoplastic left ventricle (subnormal cavity volume)|None'}
```
{{% /tab %}}

{{% tab tabNum="2" %}}
[Follow Along in Google Colab](https://colab.research.google.com/drive/1Y6r1772AW-FWZ1OrOutNoDOvca8Osz3z?usp=sharing)
```R
# installing devtools
dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
install.packages("devtools", lib = Sys.getenv("R_LIBS_USER"), repos = "https://cran.rstudio.com/")
```
```R
# installing the R client
devtools::install_github("DNAstack/ga4gh-search-client-r")
```
```R
# Making the request
library(httr)
<<<<<<< HEAD
conditionsInFemalePatients <- ga4gh.search::ga4gh_search("https://data.publisher.dnastack.com/data-connect", "select json_extract_scalar(ncpi_disease, '$.code.text') as disease, json_extract_scalar(ncpi_disease, '$.identifier[0].value') as identifier from collections.public_datasets.kidsfirst_ncpi_disease disease INNER JOIN collections.public_datasets.kidsfirst_patient patient ON patient.id=replace(json_extract_scalar(ncpi_disease, '$.subject.reference'), 'Patient/') WHERE json_extract_scalar(patient, '$.gender')='female' limit 5")
=======
conditionsInFemalePatients <- ga4gh.search::ga4gh_search("https://data.publisher.dnastack.com/data-connect", "select json_extract_scalar(ncpi_disease, '$.code.text') as disease, json_extract_scalar(ncpi_disease, '$.identifier[0].value') as identifier from collections.public_datasets.ncpi_disease disease INNER JOIN collections.public_datasets.patient patient ON patient.id=replace(json_extract_scalar(ncpi_disease, '$.subject.reference'), 'Patient/') WHERE json_extract_scalar(patient, '$.gender')='female' limit 5")
>>>>>>> 6f4366c (Corrected the data-connect endpoint and provided fake Trino endpoint for the demo)
```
```R
# View the results
print(conditionsInFemalePatients)
```

Output:
``` bash
                                               disease
1                                       Aortic atresia
2                                       Mitral atresia
3                           Hypoplasia ascending aorta
4                      Hypoplastic left heart syndrome
5 Hypoplastic left ventricle (subnormal cavity volume)
                                                                           identifier
1                                       Condition|SD_PREASA7S|272|Aortic atresia|None
2                                       Condition|SD_PREASA7S|272|Mitral atresia|None
3                           Condition|SD_PREASA7S|272|Hypoplasia ascending aorta|None
4                      Condition|SD_PREASA7S|272|Hypoplastic left heart syndrome|None
5 Condition|SD_PREASA7S|272|Hypoplastic left ventricle (subnormal cavity volume)|None
```
{{% /tab %}}


{{% tab tabNum="3" %}}

``` bash
search-cli query -q "select json_extract_scalar(ncpi_disease, '$.code.text') as disease, json_extract_scalar(ncpi_disease, '$.identifier[0].value') as identifier from collections.public_datasets.kidsfirst_ncpi_disease disease INNER JOIN collections.public_datasets.kidsfirst_patient patient ON patient.id=replace(json_extract_scalar(ncpi_disease, '$.subject.reference'), 'Patient/') WHERE json_extract_scalar(patient, '$.gender')='female' limit 5" --api-url https://data.publisher.dnastack.com/data-connect
```
{{% /tab %}}
{{% tab tabNum="4" %}}
These requests
This query returns all female patients from the `patient` table.
``` bash
curl --request POST \
  --url https://data.publisher.dnastack.com/data-connect/search \
  --header 'content-type: application/json' \
  --data '{ "query": "select * from collections.public_datasets.kidsfirst_patient WHERE json_extract_scalar(patient, '\''$.gender'\'')='\''female'\'' limit 5"}'
```

This query returns all conditions observed in female patients from the `patient` table.
``` bash
curl --request POST \
  --url https://data.publisher.dnastack.com/data-connect/search \
  --header 'content-type: application/json' \
  --data '{ "query": "select json_extract_scalar(ncpi_disease, '\''$.code.text'\'') as disease, json_extract_scalar(ncpi_disease, '\''$.identifier[0].value'\'') as identifier from collections.public_datasets.kidsfirst_ncpi_disease disease INNER JOIN collections.public_datasets.kidsfirst_patient patient ON patient.id=replace(json_extract_scalar(ncpi_disease, '\''$.subject.reference'\''), '\''Patient/'\'') WHERE json_extract_scalar(patient, '\''$.gender'\'')='\''female'\'' limit 5"}'
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}

{row-divider}
#### More Examples
##### dbGaP GECCO Example
This is a public implementation of Data Connect. Feel free to follow along with the examples and explore this endpoint with your own script.
{{< tabs tabTotal="3" tabID="3" tabName1="Python" tabName2="R" tabName3="CLI">}}
{{% tab tabNum="1" %}}
[Follow along in Colab](https://colab.research.google.com/drive/1f_BZibUx3nWdaJXkgcoW5WqwxnLDgzzY?usp=sharing)
``` python
# init search client
from search_python_client.search import SearchClient
base_url = 'https://data.publisher.dnastack.com/data-connect/'
search_client = SearchClient(base_url=base_url)
```
``` python
# Find available tables
tables_iterator = search_client.get_table_list()
tables = list(tables_iterator)
import pprint
pprint.pprint(tables)
```
```python
#Get more information about a table returned
table_info = search_client.get_table_info("collections.public_datasets.scr_gecco_susceptibility_subject_phenotypes_multi")
pprint.pprint(table_info)
```
```python
# Dig into the table a little further
table_data_iterator = search_client.get_table_data("collections.public_datasets.scr_gecco_susceptibility_subject_phenotypes_multi")
```
```python
# Limit to first 10 items
tables = [next(table_data_iterator, None) for i in range(10)]
tables = list(filter(None, tables))
pprint.pprint(tables)
```
``` python
# Select all items from the CPS-II study
query = """
SELECT *
FROM   collections.public_datasets.scr_gecco_susceptibility_subject_phenotypes_multi
WHERE  study = 'CPS-II'
LIMIT  5
"""
```
``` python
# Executing the query
table_data_iterator = search_client.search_table(query)
for item in table_data_iterator:
  print(item)
```
{{% /tab %}}
{{% tab tabNum="2" %}}
[Follow along in Colab](https://colab.research.google.com/drive/1X7EZ71v29iFnxbHjsc-9_0Om41xEw32m?usp=sharing)
``` R
# installing devtools
dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
install.packages("devtools", lib = Sys.getenv("R_LIBS_USER"), repos = "https://cran.rstudio.com/")
```
``` R
# installing the R client
devtools::install_github("DNAstack/ga4gh-search-client-r")
```
``` R
# Making the request
library(httr)
ga4gh.search::ga4gh_list_tables("https://data.publisher.dnastack.com/data-connect")
```
``` R
# Select all items from the CPS-II study
query <- "SELECT * FROM collections.public_datasets.scr_gecco_susceptibility_subject_phenotypes_multi WHERE study = 'CPS-II' LIMIT 5"
```
``` R
# Executing the query
ga4gh.search::ga4gh_search("https://data.publisher.dnastack.com/data-connect", query)
```
{{% /tab %}}
{{% tab tabNum="3" %}}
List tables
``` bash
search-cli list --api-url "https://data.publisher.dnastack.com/data-connect"
```
Get table info
``` bash
search-cli info collections.public_datasets.scr_gecco_susceptibility_subject_phenotypes_multi --api-url "https://data.publisher.dnastack.com/data-connect"
```
Now run a query and pipe the results to a file called `results.txt`
``` bash
search-cli query -q "SELECT * FROM collections.public_datasets.scr_gecco_susceptibility_subject_phenotypes_multi WHERE study = 'CPS-II' LIMIT 5" \
  --api-url "https://data.publisher.dnastack.com" > results.txt
```
{{% /tab %}}

{{< /tabs >}}

{divider}

---

##### Viral AI Example
This is a public implementation of Data Connect for Viral AI. Find more about Viral AI [here](https://viral.ai/).

{{< tabs tabTotal="3" tabID="4" tabName1="Python" tabName2="R" tabName3="CLI">}}
{{% tab tabNum="1" %}}
[Follow along in Colab](https://colab.research.google.com/drive/1hnHTqquYP2HjUF0dDHn8FKiO9f7t0yGO?usp=sharing)
``` python
from search_python_client.search import DrsClient, SearchClient
base_url = 'https://viral.ai/api/collection/world-health-organization-covid-19-global-data-repository/data-connect/'
search_client = SearchClient(base_url=base_url)

# Find available tables
tables_iterator = search_client.get_table_list()
tables = list(tables_iterator)
import pprint
pprint.pprint(tables)

# Get more information about a table returned
table_info = search_client.get_table_info(tables[0]['name'])
pprint.pprint(table_info)

# Dig into the table a little further
table_data_iterator = search_client.get_table_data(tables[0]['name'])
# Limit to first 10 items
tables = [next(table_data_iterator, None) for i in range(1)]
tables = list(filter(None, tables))
pprint.pprint(tables)
```
```python
# Select rows from three regions
query = f"""
  SELECT *
  FROM collections.world_health_organization_covid_19_global_data_repository.vaccination_data
  WHERE iso3 IN ('ASM', 'JPN', 'THA')
  LIMIT 25
"""
# Executing the query
table_data_iterator = search_client.search_table(query)

import pandas
pandas.DataFrame(table_data_iterator)
```
{{% /tab %}}
{{% tab tabNum="2" %}}
[Follow along in Colab](https://colab.research.google.com/drive/1FCpiUIHSOS-qewaw5efF8T_SipR5DSZR?usp=sharing)
``` R
# installing devtools
dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
install.packages("devtools", lib = Sys.getenv("R_LIBS_USER"), repos = "https://cran.rstudio.com/")
```
``` R
# installing the R client
devtools::install_github("DNAstack/ga4gh-search-client-r")
```
``` R
# Making the request
library(httr)
ga4gh.search::ga4gh_list_tables("https://viral.ai/api/collection/world-health-organization-covid-19-global-data-repository/data-connect/")
```
``` R
# Select all data from Genbank.
query <- "SELECT * FROM collections.world_health_organization_covid_19_global_data_repository.vaccination_data WHERE iso3 IN ('ASM', 'JPN', 'THA') LIMIT 25"
```
``` R
# Executing the query
ga4gh.search::ga4gh_search("https://viral.ai/api/collection/world-health-organization-covid-19-global-data-repository/data-connect/", query)

```
{{% /tab %}}
{{% tab tabNum="3" %}}
List tables
``` bash
search-cli list --api-url "https://viral.ai/api/collection/world-health-organization-covid-19-global-data-repository/data-connect/"
```
Get table info
``` bash
search-cli info covid.cloud.sequences --api-url "https://viral.ai/api/collection/world-health-organization-covid-19-global-data-repository/data-connect/"
```
Now run a query and pipe the results to a file called `results.txt`
``` bash
search-cli query -q "SELECT * FROM collections.world_health_organization_covid_19_global_data_repository.vaccination_data WHERE iso3 IN ('ASM', 'JPN', 'THA') LIMIT 25" \
  --api-url "https://viral.ai/api/collection/world-health-organization-covid-19-global-data-repository/data-connect/" > results.txt
```
{{% /tab %}}

{{< /tabs >}}
