# Dataset

A `Dataset` is simply an array of objects that have a common set of properties. A Dataset can be thought of as a table where each cell represents the value of a property (column) for a particular object (row).

A Dataset is made up of two blocks:

1. `schema` describes properties of objects in the Dataset (e.g. "age")
2. `objects` provide values for properties of objects in the Dataset (e.g. "age" : 30)

### Schema

The `schema` block follows the [Schema](SCHEMA.md) format.

The root objects (items of the `objects` array) must be JSON objects. Their schema must have its `type` property equal to `"object"`, not a primitive value (`string`, `number`, ..) or array.
  
### Objects

The content of the Dataset is provided in the `objects` block. Each object is a set of values with keys corresponding to keys in the `schema`.


### Examples

This is a Dataset with one schema property and two objects:

```json
{
       "schema": {
               "properties": {
                       "age" : {
                               "description": "age of a subject, in days",
                               "type": "number"
                       }
               }
       },
       "objects": [
               { "age": 30 },
               { "age": 40 }
       ]
}

```

This is a Dataset that references an externally defined schema: the [Data Repository Service](https://github.com/ga4gh/data-repository-service-schemas) developed by the GA4GH Cloud Work Stream:

```json
{
       "schema": {
               "$ref": "http://schema.ga4gh.org/drs/0.1.0#/definitions/Object"
       },
       "objects": [
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

This is a Dataset whose [Schema](SCHEMA.md) mixes inline and externally referenced properties:


```json
{
       "schema": {
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
       "objects": [
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
