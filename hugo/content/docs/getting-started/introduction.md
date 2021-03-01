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
### GA4GH Search
The GA4GH Search specification describes a simple, uniform mechanism to publish, discover, query, and analyze biomedical data. Any “rectangular” data that fits into rows and columns can be represented by GA4GH Search. 

#### GA4GH Search for Data Custodians
GA4GH Search is a perfect solution for data custodians looking to make their biomedical data discoverable and searchable. 
- The API is minimalistic by design, which also means minimal resistance to adoption. 
- GA4GH Search does not prescribe a particular data model. If it fits into rows and columns, you can publish it.
- GA4GH Search serves as a general-purpose framework for building federative search-based applications across multiple implementations.
- GA4GH Search is backend agnostic. It is possible to implement the API across a large variety of backend datastores.

#### GA4GH Search for Data Consumers
GA4GH Search is a perfect solution for data consumers looking to discover and search biomedical data in an interoperable way.
- GA4GH Search is RESTful. Read our [Open API 3 specification](/api/).
- GA4GH Search is discoverable and browsable. [See supported table operations](/docs/reference/sql-functions/)
- GA4GH Search is queryable and familiar. GA4GH Search's SQL dialect has a familiar interface inspired by current major open source database platforms.

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