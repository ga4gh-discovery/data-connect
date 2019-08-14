# Search

`Search` is a framework for searching genomics and clinical data. 

The Search framework is comprised of a collection of complementary standards that data custodians can implement to make their biomedical data more discoverable.

The schemas for most components of the framework are developed by the [Discovery Work Stream](https://github.com/ga4gh-discovery/ga4gh-discovery.github.io) of the [Global Alliance for Genomics & Health](http://ga4gh.org).

## Background

The GA4GH has previously developed two standards for discovery. `Beacon` is a standard for  discovery of genomic variants, while `Matchmaker` is a standard for discovery of subjects with certain genomic and phenotypic features. Implementations of these standards have been linked into federated networks ([Beacon Network](http//beacon-network.org) and [Matchmaker Exchange](http://matchmakerexchange.org), respectively). 

Each standard (and corresponding network) has been successful in its own right. It was acknowledged that it would be broadly useful to develop standards that abstracted common utilities for building searchable, federated networks for a variety of applications in genomics and health.

The Discovery Work Stream develops `Search` as a general-purpose framework for building federatable search-based applications.

## Goals
* `custom schemas` It is possible make arbitrary schemas and properties searchable.
* `federation` It is possible to federate searches across multiple implementations. Federations of the search framework reference common schemas and properties.
* `backend agnostic` It is possible to implement the framework across a large variety of backend datastores.

## Out of scope
* `developing data models` The Search framework **does not** define data models. It defers that effort to others in the GA4GH or outside implementers.
* `application development` The Search framework **does not** prescribe a specific application. It is intentionally general-purpose. It defers to other efforts in the Discovery Work Stream, GA4GH, and beyond to build domain-specific applications.

## Complementary standards

The following standards are complementary but not required by the Search framework:

* The [Service Info](https://github.com/ga4gh-discovery/service-info) standard can be used to describe the service
* The [Service Registry](https://github.com/ga4gh-discovery/service-registry) standard can be used to create networks of search services

## Architecture

<img src="assets/ga4gh-discovery-search.svg">
<!--
    To edit this image, load assets/ga4gh-discovery-search.xml into draw.io and regenerate svg
-->

## Components

Search API consists of [Dataset](DATASET.md) and Query APIs, describing search results and queries, respectively.

## Use cases

See [USECASES.md](USECASES.md)

### Examples

* Find subjects with HP:0001519 and candidate gene FBN1 (use case of [Matchmaker Exchange](https://www.matchmakerexchange.org/))
* Find male subjects with HP:0009726 consented for General Research Use (use case of [European Genome-phenome Archive](https://www.ebi.ac.uk/ega/home))
* Find adult males diagnosed with autism having a harmful mutation in SHANK1 (use case of [Autism Sharing Initiative](http://autismsharinginitiative.org))
* Find dataset from subject on European data center hosted on Amazon (use case of [Cloud Work Stream](https://github.com/ga4gh/wiki/wiki))

### Static implementation
It is possible to pregenerate all of the JSON documents that will be served in response to 
this API.  These include:
- ```datasets```: served in response to ```GET /datasets```
- ```dataset/{id}```: served in response to ```GET /datasets/{id}```.  e.g. a dataset with id ```mydataset``` should have a corresponding file ```/datasets/mydataset```
- ```dataset/{id}_{pageNumber}```, which will be linked in the next_page_url  of the first dataset  (e.g. ```mydataset```), or in the next_page_url/prev_page_url of previous or subsequent pages.
- ```dataset/schema/{schemaFile}```: Though not required, schemas may be linked via [$ref](https://json-schema.org/latest/json-schema-core.html#rfc.section.8.3). Schemas can also be stored as static JSON documents, and be referred to by relative or absolute URLs.

A concrete, example test implementation is [available](https://storage.googleapis.com/ga4gh-dataset-sample/datasets) (list endpoint) with [documentation](https://storage.googleapis.com/ga4gh-dataset-sample/EXAMPLE.md).

### Google Sheets implementation
A Google Sheets spreadsheet can also be exposed via the datasets API via the sheets adapter, located [here](https://github.com/DNAstack/ga4gh-search-adapter-google-sheets).

## Contributing

The GA4GH is an open community that strives for inclusivity. Teleconferences and corresponding [meeting minutes](https://docs.google.com/document/d/1sG--PPVlVWb1-_ZN7cHta79uU9tU2y-17U11PYzvMu8/edit#heading=h.lwhinfkfmlx4) are open to the public. To learn how to contribute to this effort, please email Rishi Nag ([rishi.nag@ga4gh.org](mailto:rishi.nag@ga4gh.org)). 
