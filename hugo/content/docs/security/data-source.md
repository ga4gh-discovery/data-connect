---
title: "At the data source"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: single-col
---
#### Securing the Search data sources
Search is backend agnostic by design; this means we do not suggest a specific implementation as correct. On this page, we will attempt to bring up some options for you to consider.

##### Using access controls of the data source
Whether your data is stored in a database like MySQL and PostgreSQL, or hosted solutions like Google Cloud Storage, the database will likely offer some form of access control. The access control can be broad or fine-grained, extending to table/column/row-level security. Your implementation can leverage the database's access controls to implement GA4GH Passport and Visas to secure your data. 

[Not familiar with GA4GH Passports and Visas?](https://github.com/ga4gh-duri/ga4gh-duri.github.io/tree/master/researcher_ids)


##### Using Presto’s system access control
If your implementation uses Presto, you can use Presto's [system access control](https://prestodb.io/docs/current/security/built-in-system-access-control.html) to secure your data source.

##### Make a copy of your data
If you plan to share a select set of data, you can consider making a copy of all the shared data in a different database/storage instance. Not having sensitive data in your shared data source at all is the most secure solution. If the plan is to share a specific dataset publicly, this is the best option to avoid implementing complicated filters.
