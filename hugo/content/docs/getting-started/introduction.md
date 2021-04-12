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
### Data Connect
The Data Connect API specification describes a simple, uniform mechanism to publish, discover, query, and analyze biomedical data. Any data that fits into an array of JSON (whether structured like rows and columns, like a document database, or somewhere in between) can be represented by Data Connect.

#### Data Connect for Data Custodians
Data Connect is a perfect solution for data custodians looking to make their biomedical data discoverable and searchable. 
- The API is minimalistic by design, which also means minimal resistance to adoption. 
- Data Connect does not prescribe a particular data model. If it fits into rows and columns, you can publish it.
- Data Connect serves as a general-purpose framework for building federated search-based applications across multiple implementations.
- Data Connect is backend agnostic. It is possible to implement the API across a large variety of backend datastores.

#### Data Connect for Data Consumers
Data Connect is a perfect solution for data consumers looking to discover and Data Connect biomedical data in an interoperable way.
- Data Connect is discoverable and browsable. [See supported table operations](/docs/reference/sql-functions/)
- Data Connect API is queryable and familiar. Data Connect API's contemporary SQL dialect has a familiar interface inspired by current major open source database platforms.
- The HTTP calls you can make are defined in our [OpenAPI 3 specification](/api).

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