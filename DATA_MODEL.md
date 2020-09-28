# Data Model

A `Data Model` describes [properties](#properties) of a [Table](TABLE.md).

### Data Model Format

The Data Model format follows [JSON-Schema](https://json-schema.org/) Draft 7.

### Properties

Data Model `properties` describe attributes of [Tables](TABLE.md) (e.g. a "subject" table may have an "age" property).

Properties can be defined:

- `inline` or 
- `externally` by referencing a [JSON-Schema](https://json-schema.org/) definition

#### Examples

Here are sample Data Model definitions. For more information, visit [the JSON-Schema website](https://json-schema.org/).

##### Inline Properties

This data model has one property, `age`, defined inline:

```json
{
       "data_model": {
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

This data model defines its sole property, `drs`, by referring to an external data model: the [Data Repository Service](https://github.com/ga4gh/data-repository-service-schemas) developed by the GA4GH Cloud Work Stream:

```json
{
       "data_model": {
               "properties": {
                       "drs": {
                               "$ref": "http://schema.ga4gh.org/drs/0.1.0#/definitions/Object"
                       }
               }
       }
}
```

##### Mixing Both

This data model that contains both inline and externally referenced properties:


```json
{
       "data_model": {
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
