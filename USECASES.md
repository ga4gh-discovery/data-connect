# Introduction
This document attempts to summarize a variety of use cases collected from key driver
projects and other interested parties. The information was collected from
three primary sources:

* A questionnaire that collected answers to a series of curated questions (2
  responses)

* A feature matrix spreadsheet that indexed various high level features against
  interested driver projects (6 driver projects commented on at least one
  feature in the matrix)

* A "suggested queries" document that collected high level queries that are of
  interest (6 groups replied to this document providing 19 queries)

If you contributed to one of these sources and feel that your feedback was
either missed or misrepresented here, or contributed via another channel that
was not captured, please reach out to us at ga4gh-discovery-search@ga4gh.org.

# Key themes
## Multimodal queries
In nearly all cases, the responses indicate a desire to link variant data with
phenotypic or clinical data. Only a few responses indicate a desire to query
over simple variant data (retrieving counts and allele/genotype frequency for a
variant) and even then it is a step along a path to a patient or cohort.

All responses to the feature matrix rated this as "must have".

See the section on data types below for more information.

## Controlled Access
Most responses indicate some kind of requirement for controlled access,
including tiers of access ranging from public to tightly controlled by per
sample consent terms. Although configuration of access control is outside the
scope of the Data Connect API, considerations may need to be made for expressing
these concepts in queries and responses.

## Complex Matching
In some cases (positional data for example) exact or simple fuzzy matching is
desired but for phenotypic matching needs to be performed using custom rules
and/or based on distances within an ontology hierarchy.

Other potentially interesting matching/filtering modes mentioned include:
* returning results for only de novo variants
* matching against mutational burden
* filtering for rare diseases using gnomAD
* “abnormal” RNA expression of a particular gene
* generating a confusion matrix between two groups of individuals

"Custom functions" were identified as "nice to have" (4) and "don't know" (2).

Ben Hutten notes some thoughts on the topic of matching in the [MME
repository](https://github.com/ga4gh/mme-apis/wiki/Phenotype-matching).

## Aggregation, Grouping and Sorting
Responses were mixed on the topic of aggregation. Responses on the topic of
"Aggregate functions (eg. minimum, maximum, average) range from "not needed"
(1), "nice to have" (3) to "must have" (2). There is a division here around
whether this sort of operation should be performed at query time or after the
results are generated. One important point of consideration is that in some
cases data may be available to a particular user only in aggregate meaning that
it must be performed as part of the query.

The closely related feature of grouping (for example, counting the number of
variants grouped by gene) was rated as "not needed" (3), "nice to have" (1) and
"must have" (2) by respondents.

Sorting, or the related concept of ranking, was rated as either "not needed"
(2) or "must have" (2) by respondents.

## Data types
The Data Connect API is not expected to define data types, but it will be important
that some shared vocabulary are available to facilitate federated queries.

All responses in the feature matrix indicated that the availability of a
standard set of fields is "nice to have" or "must have", while the ability to
have arbitrary non-standard fields is a "must have".

Data types mentioned in the responses include:

* Variant
* Age
* Sex
* HPO terms
* Contact information
* Method of inheritance
* Consent types (eg, to find patients with data consented for a particular use)
* Various associated clinical data and/or assessments 

In terms of how to represent these types in the API, there are a few
suggestions:

* Schema Blocks from GA4GH
* schema.org from W3C and the related DCAT project
* DATS (a joint collaboration funded by NIH)

# Caveats

## Small number of responses
This summary was produced from a relatively small amount of response data, and
the individual responses were often collected against an evolving document. In
particular, the feature matrix doubled in size between some responses, and the
questionnaire was changed completely between the two responses.

## Lack of clarity in feature definitions
The items expressed in the feature matrix are not fully defined, leaving their
interpretation up to the reader. In some cases, respondents added comments to
try to clarify how they interpreted the feature.

# Open Questions
If you have an answer to one of these questions, please either file an issue,
open a PR against this document or reach out to the list at
ga4gh-discovery-search@ga4gh.org.

* How exactly are fuzzy matches for phenotypes being performed today? For
  example: this term and up the tree, this term and down the tree, other well
  defined functions or something completely custom?
