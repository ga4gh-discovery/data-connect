---
title: "At Endpoints"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: single-col
---
#### Securing Data Connect Endpoints

A future version of Data Connect will document how to use [GA4GH Passports and Visas](https://github.com/ga4gh-duri/ga4gh-duri.github.io/tree/master/researcher_ids) to authenticate and authorize requests to the API.

There is already work underway to specify how DRS will work with Passports. Rather than jumping in now and creating confusion, the Data Connect working group is monitoring the Passport efforts in DRS and will document a specific Data Connect Passport integration that makes sense in the context of what has been decided for DRS.

For now, prefer JSON Web Tokens (JWTs) presented as OAuth2 bearer tokens on each Data Connect API request. This will likely put you in a good position to implement the recommended Passport integration when the path forward becomes clear.
