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

[Installing Client Libraries](#installing-client-libraries)

[Publishing Data Examples](/docs/getting-started/provision-data/)

[Data Consumption Examples](/docs/getting-started/consume-data/)
{{%/content-textbox%}}
{{</code/float-window>}}

{row-divider}
### Installing Client Libraries
Search has client libraries for R and Python, as well as a command-line interface. We’ll be using these client libraries in the following examples.
{divider}
{{<code/float-window>}}
{{< tabs tabTotal="3" tabID="1" tabName1="Python" tabName2="R" tabName3="CLI">}}
{{% tab tabNum="1" %}}
```bash
# Installing the client library form PyPi
pip install search-python-client
# Installing from Github
pip install git+https://github.com/DNAstack/search-python-client --no-cache-dir
```
{{% /tab %}}

{{% tab tabNum="2" %}}
```R
# Setup devtools
dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
install.packages("devtools", lib = Sys.getenv("R_LIBS_USER"), repos = "https://cran.rstudio.com/")
```
``` R
# installing the R client
devtools::install_github("DNAstack/ga4gh-search-client-r")
```
{{% /tab %}}

{{% tab tabNum="3" %}}
**This CLI requires Java 11+ on your system**
``` bash
curl https://storage.googleapis.com/ga4gh-search-cli/tables-cli-2.1-55-gc484f8b-executable.jar > search-cli
chmod +x search-cli
mv search-cli /usr/local/bin # (somewhere on your search path)
search-cli --version
```
You should see:
``` bash
tables-api-cli Version : 1.0-0.2.1-55-gc484f8b
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}