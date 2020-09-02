![](https://www.ga4gh.org/wp-content/themes/ga4gh-theme/gfx/GA-logo-horizontal-tag-RGB.svg)

# Search <a href="https://github.com/ga4gh-discovery/ga4gh-discovery-search/blob/develop/spec/search-api.yaml"><img src="http://validator.swagger.io/validator?url=https://raw.githubusercontent.com/ga4gh-discovery/ga4gh-discovery-search/develop/spec/search-api.yaml" alt="Swagger Validator" height="20em" width="72em"></a> [![](https://travis-ci.org/ga4gh-discovery/ga4gh-discovery-search.svg?branch=develop)](https://travis-ci.org/ga4gh-discovery/ga4gh-discovery-search) [![](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://raw.githubusercontent.com/ga4gh-discovery/ga4gh-discovery-search/develop/LICENSE)

`Search` is a framework for searching genomics and clinical data. 

The Search framework is comprised of a collection of complementary standards that data custodians can implement to make their biomedical data more discoverable.

The schemas for most components of the framework are developed by the [Discovery Work Stream](https://github.com/ga4gh-discovery/ga4gh-discovery.github.io) of the [Global Alliance for Genomics & Health](http://ga4gh.org).

## Background

The GA4GH has previously developed two standards for discovery. `Beacon` is a standard for  discovery of genomic variants, while `Matchmaker` is a standard for discovery of subjects with certain genomic and phenotypic features. Implementations of these standards have been linked into federated networks ([Beacon Network](http//beacon-network.org) and [Matchmaker Exchange](http://matchmakerexchange.org), respectively). 

Each standard (and corresponding network) has been successful in its own right. It was acknowledged that it would be broadly useful to develop standards that abstracted common utilities for building searchable, federated networks for a variety of applications in genomics and health.

The Discovery Work Stream develops `Search` as a general-purpose framework for building federatable search-based applications.

## Goals
* `federation` It is possible to federate searches across multiple implementations. Federations of the search framework reference common schemas and properties.
* `backend agnostic` It is possible to implement the framework across a large variety of backend datastores.

## Out of scope
* `developing data models` The Search framework **does not** define data models. It defers that effort to others in the GA4GH or outside implementers.
* `application development` The Search framework **does not** prescribe a specific application. It is intentionally general-purpose. It defers to other efforts in the Discovery Work Stream, GA4GH, and beyond to build domain-specific applications.

## How to view

Search API is specified in OpenAPI in [search-api.yaml](./spec/search-api.yaml), which [you can view using Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/ga4gh-discovery/ga4gh-discovery-search/develop/spec/search-api.yaml).

## How to test

Use [Swagger Validator Badge](https://github.com/swagger-api/validator-badge) to validate the YAML file, or its [OAS Validator](https://github.com/mcupak/oas-validator) wrapper.

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

The search API consists of [Table](TABLE.md) and Query APIs, describing search results and queries, respectively.

## Use cases

See [USECASES.md](USECASES.md)

### Examples

* Find subjects with HP:0001519 and candidate gene FBN1 (use case of [Matchmaker Exchange](https://www.matchmakerexchange.org/))
* Find male subjects with HP:0009726 consented for General Research Use (use case of [European Genome-phenome Archive](https://www.ebi.ac.uk/ega/home))
* Find adult males diagnosed with autism having a harmful mutation in SHANK1 (use case of [Autism Sharing Initiative](http://autismsharinginitiative.org))
* Find dataset from subject on European data center hosted on Amazon (use case of [Cloud Work Stream](https://github.com/ga4gh/wiki/wiki))

## Implementations and tooling

- [Tables-in-a-bucket (no-code implementation)](#dataset-in-a-bucket-no-code-implementation)
- [Google Sheets implementation](#google-sheets-implementation)

### Tables-in-a-bucket (no-code implementation)
The specification allows for a no-code implementation as a collection of files served statically (e.g. in a cloud bucket, or a Git repository). To do this, you need the following JSON files:

- ```tables```: served in response to ```GET /tables```
- ```table/{table_name}/info```: served in response to ```GET /table/{table_name}/info```.  e.g. a table with the name ```mytable``` should have a corresponding file ```table/mytable/info```
- ```table/{table_name}/data```: served in response to ```GET /table/{table_name}/data```.  e.g. a table with the name ```mytable``` should have a corresponding file ```table/mytable/data```
- ```table/{table_name}/data_{pageNumber}```, which will be linked in the next_page_url of the first table  (e.g. ```mytable```).
- ```table/{table_name}/data_models/{schemaFile}```: Though not required, data models may be linked via [$ref](https://json-schema.org/latest/json-schema-core.html#rfc.section.8.3). Data models can also be stored as static JSON documents, and be referred to by relative or absolute URLs.

A concrete, example test implementation is [available](https://storage.googleapis.com/ga4gh-tables-example/tables) (list endpoint) with [documentation](https://storage.googleapis.com/ga4gh-tables-example/EXAMPLE.md).

### Google Sheets implementation
A Google Sheets spreadsheet can also be exposed via the tables API via the sheets adapter, located [here](https://github.com/DNAstack/ga4gh-search-adapter-google-sheets).

## Security

Sensitive information transmitted over public networks, such as access tokens and human genomic data, MUST be protected using Transport Level Security (TLS) version 1.2 or later, as specified in [RFC 5246](https://tools.ietf.org/html/rfc5246).

If the data holder requires client authentication and/or authorization, then the client’s HTTPS API request MUST present an OAuth 2.0 bearer access token as specified in [RFC 6750](https://tools.ietf.org/html/rfc6750), in the `Authorization` request header field with the Bearer authentication scheme:

```
Authorization: Bearer [access_token]
```

The policies and processes used to perform user authentication and authorization, and the means through which access tokens are issued, are beyond the scope of this API specification. GA4GH recommends the use of the [OpenID Connect](https://openid.net/connect/) and [OAuth 2.0 framework (RFC 6749)](https://tools.ietf.org/html/rfc6749) for authentication and authorization.

## CORS
Cross-origin resource sharing (CORS) is an essential technique used to overcome the same origin content policy seen in browsers. This policy restricts a webpage from making a request to another website and leaking potentially sensitive information. However the same origin policy is a barrier to using open APIs. GA4GH open API implementers should enable CORS to an acceptable level as defined by their internal policy. For any public API implementations should allow requests from any server.

GA4GH published a [CORS best practices document](https://docs.google.com/document/d/1Ifiik9afTO-CEpWGKEZ5TlixQ6tiKcvug4XLd9GNcqo/edit?usp=sharing), which implementers should refer to for guidance when enabling CORS on public API instances.

## How to contribute

The GA4GH is an open community that strives for inclusivity. Guidelines for contributing to this repository are listed in [CONTRIBUTING.md](CONTRIBUTING.md). Teleconferences and corresponding [meeting minutes](https://docs.google.com/document/d/1sG--PPVlVWb1-_ZN7cHta79uU9tU2y-17U11PYzvMu8/edit#heading=h.lwhinfkfmlx4) are open to the public. To learn how to contribute to this effort, please email Rishi Nag ([rishi.nag@ga4gh.org](mailto:rishi.nag@ga4gh.org)). 

## How to notify GA4GH of potential security flaws

Please send an email to security-notification@ga4gh.org.
