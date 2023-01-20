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

In the [provision data section](/docs/getting-started/provision-data/), we've shown a quick start recipe with the [data-connect-trino](https://github.com/DNAstack/data-connect-trino) docker container connected to a Trino instance hosted at `https://data.publisher.dnastack.com/data-connect/`. This section provides more information on how this was accomplished.

{{<code/float-window>}}
{{%content-textbox%}}
##### Quick Links
---
[data-connect-trino](https://github.com/DNAstack/data-connect-trino)

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
> If you don't have a Trino server to work against and you wish to try the app, try using `https://data.publisher.dnastack.com/data-connect/` as the data source.

**1. Building the Trino Adapter App**

Clone the repository
``` bash
git clone https://github.com/DNAstack/data-connect-trino.git
```
Build the app
```bash
./mvnw clean package
```


**2. Configuration**

For a minimal configuration, we need a local PostgreSQL database where the app stores its bookkeeping information. By default, the app looks for a local PostgreSQL instance at localhost:5432 with username, password, and database name `dataconnecttrino`. You can spin up such a database with this docker command:
```bash
docker run -d -p 5432:5432 --name data-connect-app-db -e POSTGRES_USER=dataconnecttrino -e POSTGRES_PASSWORD=dataconnecttrino postgres
```

Now you only need to provide two parameters: `PRESTO_DATASOURCE_URL` and `SPRING_PROFILES_ACTIVE`.

`PRESTO_DATASOURCE_URL` points to the Trino server you wish to expose with a Data Connect API.

`SPRING_PROFILES_ACTIVE` is used to disable OAuth authentication, which simplifies first-time setup.
{{%content-textbox%}}
``` bash
export PRESTO_DATASOURCE_URL=https://<your-presto-server>
export SPRING_PROFILES_ACTIVE=no-auth
```
{{%/content-textbox%}}

**3. Run the adapter App**

{{%content-textbox%}}
``` bash
./mvnw clean spring-boot:run
```
Your application should now be accessible at [http://localhost:8089/tables](http://localhost:8089/tables)

To test the app out, follow the [consuming data](/docs/getting-started/consume-data/) section.
{{%/content-textbox%}}

#### Further Configuration
Further configuration can be found at: [data-connect-trino](https://github.com/DNAstack/data-connect-trino).
