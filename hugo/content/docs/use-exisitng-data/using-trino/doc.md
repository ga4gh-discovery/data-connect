---
title: "Using Trino"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: single-col
---
### The dbGaP GECCO Example

In the [provision data section](/docs/getting-started/provision-data/), we've shown a quick start recipe with the [ga4gh-search-adapter-presto](https://github.com/DNAstack/ga4gh-search-adapter-presto) docker container connected to a Trino instance hosted at `https://presto-public.prod.dnastack.com`. This section provides more information on how this was accomplished.

{{<code/float-window>}}
{{%content-textbox%}}
##### Quick Links
---
[ga4gh-search-adapter-presto](https://github.com/DNAstack/ga4gh-search-adapter-presto)

[Open API 3 Reference](/api)

[Full Data Connect Specification](https://github.com/ga4gh-discovery/data-connect/blob/develop/SPEC.md)

[Table Object Specification](https://github.com/ga4gh-discovery/data-connect/blob/develop/TABLE.md)

[Data Connect API’s SQL dialect](https://github.com/ga4gh-discovery/data-connect/blob/develop/SPEC.md#sql-functions)

{{%/content-textbox%}}
{{</code/float-window>}}

#### Prerequisites 
The following is required before we start.
1. Java 11+
1. A Trino server you can access anonymously over HTTP(S).
1. Git
> If you don't have a Trino server to work against and you wish to try the app, try using `https://presto-public.prod.dnastack.com` as the data source.

**1. Building the Trino Adapter App**

Clone the repository
``` bash
git clone https://github.com/DNAstack/ga4gh-search-adapter-presto.git
```
Build the app
```bash
mvn clean package
``` 


**2. Configuration**

For a minimal configuration, we need to provide two parameters, `PRESTO_DATASOURCE_URL` and `SPRING_PROFILES_ACTIVE`.

`PRESTO_DATASOURCE_URL` points to the Trino server you wish to expose with a Data Connect API.
{{%content-textbox%}}
Clone the repository:
``` bash
export PRESTO_DATASOURCE_URL=https://<your-presto-server>
export SPRING_PROFILES_ACTIVE=no-auth
```
The adapter app requires a local PostgreSQL database connection. To start the app locally with the default settings, you can spin up the database with this docker command:
```bash
docker run -d -p 5432:5432 --name ga4ghsearchadapterpresto -e POSTGRES_USER=ga4ghsearchadapterpresto -e POSTGRES_PASSWORD=ga4ghsearchadapterpresto postgres
``` 
{{%/content-textbox%}}

**3. Run the adapter App**

{{%content-textbox%}}
``` bash
mvn clean spring-boot:run
```
Your application should now be accessible at [http://localhost:8089/tables](http://localhost:8089/tables)

To test the app out, follow the [consuming data](/docs/getting-started/consume-data/) section.
{{%/content-textbox%}}

#### Further Configuration
Further configuration can be found at: [https://github.com/DNAstack/ga4gh-search-adapter-presto](https://github.com/DNAstack/ga4gh-search-adapter-presto).
