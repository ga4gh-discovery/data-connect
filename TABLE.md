# Table

A `Table` is a high level object containing metadata which describes the underlying data and data model. The `Table` object does not contain the actual data.

The `Table` object is comprised of three properties:

1. `data_model` describes properties of objects in the Table (e.g. "age")
2. `name` A unique name identifying the Table (e.g. "subjects")
3. `description` describes the Table in a human readable way (e.g. "Human age data")

# Table Data

The `TableData` is simply an array of objects that have a common set of properties. A `TableData` object can be thought of as a table where each cell represents the value of a property (column) for a particular object (row).

The `TableData` object is made up of two blocks:

1. `data_model` describes properties of objects in the TableData (e.g. "age")
2. `data` provide values for properties of objects in the TableData (e.g. "age" : 30)

### Data Model

The `data_model` block follows the [Data Model](DATA_MODEL.md) format.

The root objects (items of the `data` array) must be JSON objects. Their data_model must have its `type` property equal to `"object"`, not a primitive value (`string`, `number`, ..) or array.
  
### Data

The content of the `TableData` is provided in the `data` block. Each object is a set of values with keys corresponding to keys in the `data_model`.


### Examples


This is a `Table` with one data_model property and meta data describing the table:

```json
{
       "data_model": {
               "properties": {
                       "age" : {
                               "description": "age of a subject, in days",
                               "type": "number"
                       }
               }
       },
       "name": "subjects",
        "description": "Information on all subjects in the study"
}
```


This is a `TableData` with one data_model property and two objects:

```json
{
       "data_model": {
               "properties": {
                       "age" : {
                               "description": "age of a subject, in days",
                               "type": "number"
                       }
               }
       },
       "data": [
               { "age": 30 },
               { "age": 40 }
       ]
}

```

This is a `TableData` that references an externally defined data_model: the [Data Repository Service](https://github.com/ga4gh/data-repository-service-schemas) developed by the GA4GH Cloud Work Stream:

```json
{
       "data_model": {
               "$ref": "http://schema.ga4gh.org/drs/0.1.0#/definitions/Object"
       },
       "data": [
               {
                       "id": "file-001",
                       "name": "file-001.txt",
                       "size": 100,
                       "created": "2019-01-01T12:00:01Z",
                       "checksums": [
                       ],
                       "access_methods": [
                               {
                                       "type": "https"
                               }
                       ]
               },
               {
                       "id": "file-002",
                       "name": "file-002.txt",
                       "size": 101,
                       "created": "2019-01-01T12:00:00Z",
                       "checksums": [
                       ],
                       "access_methods": [
                               {
                                       "type": "https"
                               }
                       ]
               }
       ]
}
```

This is a `TableData` whose [Data Model](DATA_MODEL.md) mixes inline and externally referenced properties:


```json
{
       "data_model": {
               "description": "A collection of subjects and their data objects",
               "properties": {
                       "subject": {
                               "type": "object",
                               "properties": {
                                       "id": {
                                               "description": "anonymous identifier of a subject",
                                               "type": "string"
                                       },
                                       "age": {
                                               "description": "age of a subject, in years",
                                               "type": "number"
                                       }
                               }
                       },
                       "drs": {
                               "$ref": "http://schema.ga4gh.org/drs/0.1.0#/definitions/Object"
                       }
               }
       },
       "data": [
               {
                       "subject": {
                               "id": "ABC100",
                               "age": 30,
                       },
                       "drs": {
                               "id": "file-001",
                               "name": "file-001.txt",
                               "size": 100,
                               "created": "2019-01-01T12:00:01Z",
                               "checksums": [
                               ],
                               "access_methods": [
                                       {
                                               "type": "https"
                                       }
                               ]
                       }
               },
               {
                       "subject": {
                               "id": "ABC101",
                               "age": 40,
                       },
                       "drs": {
                               "id": "file-002",
                               "name": "file-002.txt",
                               "size": 101,
                               "created": "2019-01-01T12:00:00Z",
                               "checksums": [
                               ],
                               "access_methods": [
                                       {
                                               "type": "https"
                                       }
                               ]
                       }
               }
       ]
}
```
