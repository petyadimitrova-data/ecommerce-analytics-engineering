# Data Quality Strategy

The project uses dbt generic tests to validate structural integrity of the dimensional warehouse.

Current generic tests include:

- unique
- not_null
- relationships

Business rule validation is implemented through custom SQL tests where appropriate.

The objective is to detect data quality issues automatically during every dbt build.