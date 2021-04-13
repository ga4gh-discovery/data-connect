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

Data Connect is a standard for discovery and searching of biomedical data, developed by the [Discovery Work Stream](https://github.com/ga4gh-discovery/ga4gh-discovery.github.io) of the [Global Alliance for Genomics & Health](http://ga4gh.org).

The standard provides a mechanism for:

- Describing data and its data model.
    - Data Connect's _Table API_ component provides a way to organize data into "Tables" and describing their data model, leveraging the JSON Schema standard.
- Searching the data with the given data model.
    - Data Connect's _Search API_ component provides a way to query "Tables" of data, leveraging the SQL standard.

It is NOT in the scope of the standard to:

- Define said data models.
    - Data Connect relies on other efforts in GA4GH (e.g. [SchemaBlocks](https://schemablocks.org/)), as well as outside implementers.

### Background

The GA4GH has previously developed two standards for discovery. `Beacon` is a standard for  discovery of genomic variants, while `Matchmaker` is a standard for discovery of subjects with certain genomic and phenotypic features. Implementations of these standards have been linked into federated networks ([Beacon Network](http//beacon-network.org) and [Matchmaker Exchange](http://matchmakerexchange.org), respectively).

Each standard (and corresponding network) has been successful in its own right. It was acknowledged that it would be broadly useful to develop  standards that abstracted common infrastructure for building searchable, federated networks for a variety of applications in genomics and health.

Data Connect, formerly known as _GA4GH Search_, is this general-purpose middleware for building federated, search-based applications. The name of the API reflects its purpose of:

- Giving data providers a way to enable connecting to their data via the described data models.
- Allowing data consumers to make connections in the data through a flexible query language.

### Benefits

- Simple, interoperable, uniform mechanism to publish, discover, query, and analyze biomedical data.
- Flexibility. Works with any data that can be serialized as an array of JSON objects. Recommends the use of SchemaBlocks data models, but allows custodians to specify their own data models make their data available without extensive ETL transformations.
- Supports federation. Serves as a general-purpose framework for building federatable search-based applications across multiple implementations. Federations reference common schemas and properties.
- Minimal by design. The API is purposely kept minimal so that the barriers to publishing existing data are as small as possible.
- Backend agnostic. It is possible to implement the API across a large variety of backend datastores.
- General purpose. Admits use cases that have not yet been thought of.

### Use cases

Data Connect is an intentionally general-purpose middleware meant to enable development of a diverse ecosystem of applications.

The community has built the following applications on top of Data Connect:

- Data Explorers
- Beacons
- Patient matchmaking
- Jupyter notebooks
- R data frames
- Command line query tools
- Data and metadata indexers
- Data federations
- Concept cross-references

We're looking forward to seeing things we haven’t yet imagined!

The community has also connected data through the following data sources:

- FHIR
- Relational databases
- CSV/TSV files with data dictionaries
- VCF+TBI files
- Phenopackets
- Google BigQuery
- Google Sheets
- and more!

Examples of queries on the data that can be answered via Data Connect include:

- Find subjects with HP:0001519 and candidate gene FBN1 (use case of [Matchmaker Exchange](https://www.matchmakerexchange.org/))
- Find male subjects with HP:0009726 consented for General Research Use (use case of [European Genome-phenome Archive](https://www.ebi.ac.uk/ega/home))
- Find adult males diagnosed with autism having a harmful mutation in SHANK1 (use case of [Autism Sharing Initiative](http://autismsharinginitiative.org))
- Find dataset from subject on European data center hosted on Amazon (use case of [Cloud Work Stream](https://github.com/ga4gh/wiki/wiki))

Full summary of use cases can be found in [USECASES.md](USECASES.md).

{divider}
{{<code/float-window>}}
{{%content-textbox%}}
##### Quick Links
---
[Specification](/api)

[Installing Client Libraries](/docs/getting-started/clients/)

[Publishing Data Examples](/docs/getting-started/provision-data/)

[Data Consumption Examples](/docs/getting-started/consume-data/)
{{%/content-textbox%}}
{{</code/float-window>}}