---
title: "SQL Functions"
weight: 1
draft: false
lastmod: 2020-12-3
type: docs
layout: single-col
---
Data Connect's SQL dialect has been selected for compatibility with current major open source database platforms including Trino, PostgreSQL, and MySQL, and BigQuery. There are occasional name or signature differences, but a Data Connect implementation atop any of the major database platforms should be able to pass through queries that use the functions listed below with only minor tweaks.

The functions below are a subset of those available in Trino 341. In a conformant Data Connect implementation, these functions must behave according to the Trino documentation. To assist with implementations directly on other database platforms, the [Trino Functions Support Matrix](https://docs.google.com/document/d/1y51qNuoe2ELX9kCOyQbFB4jihiKt2N8Qcd6-zzadIvk) captures the differences between platforms in granular detail. 

*   **Logical Operators**
    *   `AND`, `OR`, `NOT`
*   **Comparison Operators**
    *   `&lt;`, `>`, `&lt;=`, `>=`, `=`, `&lt;>`, `!=`
    *   `BETWEEN, IS NULL, IS NOT NULL`
    *   `IS DISTINCT FROM`*
    *   `IS NOT DISTINCT FROM`*
    *   `GREATEST`, `LEAST`
    *   Quantified Comparison Predicates: `ALL`, `ANY` and `SOME`*
    *   Pattern Comparison: `LIKE`
*   **Conditional Expressions**
    *   `CASE`, `IF`, `COALESCE`, `NULLIF`
*   **Conversion Functions**
    *   `cast(value AS type)` → `type`
    *   `format(format, args...)` → `varchar`
*   **Mathematical Functions**
    *   Most basic functions are supported across implementations. Notably missing are hyperbolic trig functions, infinity, floating point, and statistical/CDF functions.
    *   `abs(x)` → [same as input]
    *   `ceil(x)` → [same as input]
    *   `ceiling(x)` → [same as input]
    *   `degrees(x)` → `double`*
    *   `exp(x)` → `double`
    *   `floor(x)` → [same as input]
    *   `ln(x)` → `double`
    *   `log(b, x)` → `double`
    *   `log10(x)` → `double`
    *   `mod(n, m)` → [same as input]
    *   `pi()` → `double`
    *   `pow(x, p)` → `double`*
    *   `power(x, p)` → `double`
    *   `radians(x)` → `double`*
    *   `round(x)` → [same as input]
    *   `round(x, d)` → [same as input]
    *   `sign(x)` → [same as input]
    *   `sqrt(x)` → `double`
    *   `truncate(x)` → `double`*
    *   Random Functions:
        *   `rand()` → `double`*
        *   `random()` → `double`*
        *   `random(n)` → [same as input]*
        *   `random(m, n)` → [same as input]*
    *   Trigonometric Functions:
        *   `acos(x)` → `double`
        *   `asin(x)` → `double`
        *   `atan(x)` → `double`
        *   `atan2(y, x)` → `double`
        *   `cos(x)` → `double`
        *   `sin(x)` → `double`
        *   `tan(x)` → `double`
*   **Bitwise Functions**
    *   `bitwise_and(x, y)` → `bigint`
    *   `bitwise_or(x, y)` → `bigint`
    *   `bitwise_xor(x, y)` → `bigint`
    *   `bitwise_not(x)` → `bigint`
    *   `bitwise_left_shift(value, shift)` → [same as value]
    *   `bitwise_right_shift(value, shift, digits)` → [same as value]
    *   `bit_count(x, bits)` → `bigint`*
*   **Regular Expression Functions**
    *   `regexp_extract_all(string, pattern)` -> `array(varchar)`*
    *   `regexp_extract_all(string, pattern, group)` -> `array(varchar)`*
    *   `regexp_extract(string, pattern)` → `varchar`*
    *   `regexp_extract(string, pattern, group)` → `varchar`*
    *   `regexp_like(string, pattern)` → `boolean`*
    *   `regexp_replace(string, pattern)` → `varchar`*
    *   `regexp_replace(string, pattern, replacement)` → `varchar`*
    *   `regexp_replace(string, pattern, function)` → `varchar`*
*   **UUID Functions**
    *   `uuid()*`
*   **Session Information Functions**
    *   `current_user`*
*   **String manipulation**
    *   **Operators:**
        *   `Concatenation (||)`*
        *   `LIKE`
    *   **Functions:**
        *   `chr(n)` → `varchar`*
        *   `codepoint(string)` → `integer`*
        *   `format(format, args...)` → `varchar`
        *   `length(string)` → `bigint`
        *   `lower(string)` → `varchar`
        *   `lpad(string, size, padstring)` → `varchar`
        *   `ltrim(string)` → `varchar`
        *   `position(substring IN string)` → `bigint`*
        *   `replace(string, search, replace)` → `varchar`
        *   `reverse(string)` → `varchar`
        *   `rpad(string, size, padstring)` → `varchar`
        *   `rtrim(string)` → `varchar`
        *   `split(string, delimiter, limit)` -> `array(varchar)`*
        *   `starts_with(string, substring)` → `boolean`*
        *   `strpos(string, substring)` → `bigint`*
        *   `substr(string, start)` → `varchar`*
        *   `substring(string, start)` → `varchar`
        *   `substr(string, start, length)` → `varchar`*
        *   `substring(string, start, length)` → `varchar`
        *   `trim(string)` → `varchar`
        *   `upper(string)` → `varchar`
*   **Date manipulation** 
>Be aware of different quotation (`'`) syntax requirements between MySQL and PostgreSQL. BigQuery does not support the `+`/`-` operators for dates. Convenience methods could be replaced with `EXTRACT()`.

*   **Operators:**
    *   `+`, `- *`
    *   `AT TIME ZONE`*
*   **Functions:**
    *   `current_date`
    *   `current_time`
    *   `current_timestamp`
    *   `current_timestamp(p)`*
    *   `date(x)` → `date`*
    *   `date_trunc(unit, x)` → [same as input]*
    *   `date_add(unit, value, timestamp)` → [same as input]*
    *   `date_diff(unit, timestamp1, timestamp2)` → `bigint`*
    *   `extract(field FROM x)` → `bigint`*
    *   `from_unixtime(unixtime)` -> `timestamp(3)`*
    *   `from_unixtime(unixtime, zone)` → `timestamp(3) with time zone`*
    *   `from_unixtime(unixtime, hours, minutes)` → `timestamp(3) with time zone`*
    *   `Localtime`*
    *   `localtimestamp`*
    *   `localtimestamp(p)`*
    *   `now()` → `timestamp(3)` with time zone*
    *   `to_unixtime(timestamp)` → `double`*
*   **MySQL-like date functions:**
    *   `date_format(timestamp, format)` → `varchar`*
    *   `date_parse(string, format)` → `timestamp(3)`*
*   **Aggregate functions** 
**Note that Trino provides a much larger superset of functions. Bitwise, map, and approximate aggregations are mostly absent. Only BigQuery has a few native approximate aggregation functions.
    *   `array_agg(x)` → `array&lt;`[same as input]>*
    *   `avg(x)` → `double`
    *   `bool_and(boolean)` → `boolean`*
    *   `bool_or(boolean)` → `boolean`*
    *   `count(*)` → `bigint`*
    *   `count(x)` → `bigint`
    *   `count_if(x)` → `bigint`*
    *   `every(boolean)` → `boolean`*
    *   `max(x)` → [same as input]
    *   `max(x, n)` → `array&lt;`[same as x]>*
    *   `min(x)` → [same as input]
    *   `min(x, n)` → `array&lt;`[same as x]>*
    *   `sum(x)` → [same as input]
    *   **Statistical Aggregate Functions:**
        *   `corr(y, x)` → `double`*
        *   `covar_pop(y, x)`→ `double`*
        *   `covar_samp(y, x)` → `double`*
        *   `stddev(x)` → `double`
        *   `stddev_pop(x)` → `double`
        *   `stddev_samp(x)` → `double`
        *   `variance(x)` → `double`
        *   `var_pop(x)` → `double`
        *   `var_samp(x)` → `double`
*   **Window functions**
    *   **Ranking Functions:**
        *   `cume_dist()` → `bigint`
        *   `dense_rank()` → `bigint`
        *   `ntile(n)` → `bigint`
        *   `percent_rank()` → `double`
        *   `rank()` → `bigint`
        *   `row_number()` → `bigint`
    *   **Value Functions:**
        *   `first_value(x)` → [same as input]
        *   `last_value(x)` → [same as input]
        *   `nth_value(x, offset)` → [same as input]
        *   `lead(x[, offset[, default_value]])` → [same as input]
        *   `lag(x[, offset[, default_value]])` → [same as input]
*   **JSON functions**
In general, function signatures and behaviour differs across implementations for many JSON related functions.
    *   `json_array_length(json)` → `bigint`*
    *   `json_extract(json, json_path)` → `json`*
    *   `json_extract_scalar(json, json_path)` → varchar*
    *   `json_format(json)` → `varchar`*
    *   `json_size(json, json_path)` → `bigint`*
*   Functions for working with nested and repeated data (`ROW` and `ARRAY`) 
See also `UNNEST`, which is part of the SQL grammar and allows working with nested arrays as if they were rows in a joined table.

Note: Arrays are mostly absent in MySQL
    *   Array Subscript Operator: `[]`
    *   Array Concatenation Operator: `||`
    *   `concat(array1, array2, ..., arrayN)` → `array`
    *   `cardinality(x)` → `bigint`*
*   `ga4gh_type` [described in the Data Connect specification](https://github.com/ga4gh-discovery/data-connect/blob/develop/SPEC.md#attaching-semantic-data-types-to-search-results)
