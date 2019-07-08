# Schema

A `Schema` describes [properties](#properties) of a [Dataset](DATASET.md).

### Schema Format

The Schema format follows [JSON-Schema](https://json-schema.org/) Draft 7.

### Properties

Schema `properties` describe attributes of [Datasets](DATASET.md) (e.g. a "subject" dataset may have an "age" property).

Properties can be defined:

- `inline` or 
- `externally` by referencing a [JSON-Schema](https://json-schema.org/) definition

#### Examples

Here are sample Schema definitions. For more information, visit [the JSON-Schema website](https://json-schema.org/).

##### Inline Properties

This schema has one property, `age`, defined inline:

```json
{
       "schema": {
               "properties": {
                       "age" : {
                               "description": "age of a subject, in whole years",
                               "type": "number"
                       }
               }
       }
}
```

##### Externally Defined Properties

This schema defines its sole property, `drs`, by referring to an external data model: the [Data Repository Service](https://github.com/ga4gh/data-repository-service-schemas) developed by the GA4GH Cloud Work Stream:

```json
{
       "schema": {
               "properties": {
                       "drs": {
                               "$ref": "http://schema.ga4gh.org/drs/0.1.0#/definitions/Object"
                       }
               }
       }
}
```

##### Mixing Both

This Schema that contains both inline and externally referenced properties:


```json
{
       "schema": {
               "description": "A collection of subjects and their data objects",
               "properties": {
                       "subject": {
                               "type":"object",
                               "properties": {
                                       "id": {
                                               "description": "anonymous identifier of a subject",
                                               "type": "string"
                                       },
                                       "age": {
                                               "description": "age of a subject, in whole years",
                                               "type": "number"
                                       }
                               }
                       },
                       "drs": {
                               "$ref": "http://schema.ga4gh.org/drs/0.1.0#/definitions/Object"
                       }
               }
       }
}
```
