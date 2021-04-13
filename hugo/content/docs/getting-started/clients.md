---
title: "Install Clients"
weight: 2
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: two-col
---
{row-divider}
#### Installing Client Libraries
Data Connect has client libraries for R and Python, as well as a command-line interface. We’ll be using these client libraries in the following examples.
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
mv search-cli /usr/local/bin # (somewhere on your path)
search-cli --version
```
You should see:
``` bash
tables-api-cli Version : 1.0-0.2.1-55-gc484f8b
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}