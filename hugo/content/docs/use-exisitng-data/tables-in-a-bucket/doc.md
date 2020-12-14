---
title: "Tables-in-a-bucket"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: single-col
---
#### What is a phenopacket?
Phenopacket is a GA4GH approved standard file format for sharing phenotypic information. 

Find [documentation for phenopackets-schema](https://phenopackets-schema.readthedocs.io/en/latest/) here.

#### What does it contain?
- A set of mandatory and optional fields to share information about a patient or participant’s phenotype
- Optional fields may include clinical diagnosis, age of onset, results from lab tests, and disease severity.

An example of the JSON structure can be found [here](https://schemablocks.org/schemas/sb-phenopackets/current/Phenopacket.json).

#### Preparing the data into a GA4GH Search application
If you need some phenopackets data to follow this example, consider the following:
- Human Phenotype Ontology phenopackets downloaded from a publicly available metadata source: https://zenodo.org/record/3905420#.X3Sd2pNKj6h.
- Gecco Biosample phenopackets.

1. Clone this repository: `https://github.com/DNAstack/tables-loader`
2. All phenopacket JSON files should be added under <repo_root>/resources/phenopackets
3. Create a Google storage bucket with public access. [Creating Storage Buckets](https://cloud.google.com/storage/docs/creating-buckets)
4. Create a service account and grant "Storage Admin" access to your storage bucket. You should automatically begin downloading the access key. ***Store this access key somewhere safe, you'll need it later**

#### Running the Spring application
1. Export this environment variable: `GOOGLE_APPLICATION_CREDENTIALS=<service_account_json_file_path>`
2. Start the Spring application. (With your Java IDE or `mvn clean spring-boot:run` in bash)
3. You should see the following at `http://localhost:8080/`: `Welcome to Phenopackets tables loader application!`


#### Available API endpoints
`/create-tables-files/{tableStructure}`:
Creates tables, info and data files for all phenopackets JSON present in <repo_root>/resources/phenopackets directory

`/upload-files/{tableStructure}`
Uploads all files under <repo_root>/resources/ga4gh-phenopackets-example/<by_subject|flat> to Google cloud storage bucket ga4gh-phenopackets-example

`phenopacket/{tableStructure}/tables`
Gets <repo_root>/resources/ga4gh-phenopackets-example/<by_subject|flat>/tables json file

`phenopacket/{tableStructure}/table/{tableName}/info`
Gets <repo_root>/resources/ga4gh-phenopackets-example/<by_subject|flat>/table/info file

`phenopacket/{tableStructure}/table/{tableName}/data`
Gets <repo_root>/resources/ga4gh-phenopackets-example/<by_subject|flat>/table/data file


