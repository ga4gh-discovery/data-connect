---
title: "At Data Sources"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: single-col
---
#### Securing Data Sources

This page discusses different approaches to securing a Data Connect implementation depending on which implementation path you choose and how complex your access needs are.

Data Connect can be implemented in many ways:

* as static files in a web server or cloud bucket ("tables in a bucket")
* in front of a single database server (for example, PostgreSQL, MySQL, or ElasticSearch)
* in front of many database servers (for example, using Trino)

In addition, your dataset might require a single tier of access, where someone either has access to the whole thing or nothing at all, or you might require multiple access tiers where different users can access different subsets of the data.

#### Tables in a Bucket

If you implement Data Connect using static JSON files in a web server or cloud file storage system, you can set the web server or cloud bucket to require an authentication tokens with each request.

If you are hosting your tables in a web server such as nginx, Express.js, Tomcat, or Apache HTTPD, you have the option of providing a custom authentication module that understands JWT bearer tokens.

With data consumers accessing cloud buckets directly, the easiest approach is to use an authentication mechanism supported by the cloud vendor. This may be acceptable if the data consumers are inside your own organization, and they already have a way to obtain cloud credentials.

To customize the authentication mechanism on tables-in-a-bucket (for example, if you are experimenting with a GA4GH Passport integration) then you may have a few options, depending on the cloud platform:

1. Put your cloud bucket behind an HTTP proxy that checks authentication in a custom way. If you do this, ensure links such as `nextPageUrl` are relative in all your JSON files.
1. Check if your cloud storage system can delegate request authorization to a serverless function that you supply (eg. AWS Lambda, Google Cloud Function, Azure Function). This may be possible directly, or you may need to route requests through an API Gateway.

##### Multi Tiered Access

With tables-in-a-bucket, consider creating separate Data Connect implementations, each in their own bucket, for each access tier. This allows you to keep access policies uniform with each bucket, and gives you the flexibility to provide different data granularity to users within each tier. 

#### In Front of a Single Database

In this case, you will be running custom server code that translates incoming requests from Data Connect API requests into the format natively understood by your backend database.

##### Single Tiered Access

Create a single database user for your Data Connect API server. Grant this user read-only access to only the tables that you wish to expose via Data Connect. Your custom server will access the database as this user.

On each incoming Data Connect HTTP request, check for a valid OAuth2 bearer token. If the token is valid, make the corresponding request to the backend database. The Data Connect API user's scope of access will be limited to what the database user can see.

##### Multi Tiered Access

Create a database user for each access tier your Data Connect API server will support. Grant each user read-only access to only the tables that you wish to expose at that access tier. Your custom server will select the correct database user based on the credentials in the incoming requests.

On each incoming Data Connect HTTP request, check for a valid JWT OAuth2 bearer token. If the token is valid, examine its claims and select the appropriate database user. The Data Connect API user's scope of access will be limited to what the database user for their access tier can see.

If some access tiers should only see data at a coarser grain (for example, cohort-level statistics rather than subject-level data), consider one of the following approaches:

* create views of the data that only reveal data at the coarser grain, and grant the 'tiered database users' access to these views only
* pre-aggregate the data into tables or materialized views, and grant the 'tiered database users' access to these tables or materialized views only

Since there will typically be many more users with access to the coarser-grained view of the data, pre-aggregating the data offers a performance advantage as well.

#### In Front of Many Databases

If you are exposing many databases under a single Data Connect API instance, you are probably using a Trino based implementation.

Trino provides the [SystemAccessControl interface](https://github.com/trinodb/trino/blob/master/core/trino-spi/src/main/java/io/trino/spi/security/SystemAccessControl.java) which you can implement yourself to secure your data source.

A Trino-based Data Connect implementation will have a Data Connect API adapter service in front of Trino which accepts Data Connect API calls and relays them to Trino in its own API, just like the single database case outlined above. The adapter service should extract the user's JWT bearer token from the inbound request and include it in the Trino request under the `X-Trino-Extra-Credential` header.

From there, your implementation of the SystemAccessControl interface will have access to the JWT and its claims, and will be able to control access:

* Allow/Deny:
  * Access per catalog, schema, table, and column
  * Access to see the definition of a view
* Filter:
  * Visibility of catalogs, schemas, tables, and columns
  * Row-by-row table data using a filter expression
