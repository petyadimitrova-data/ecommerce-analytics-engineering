## Question Answered:
How does data flow through the solution?

## Purpose:
Describe the end-to-end architecture and transformation flow.

## Planned Architecture

```mermaid
flowchart TD
    A[Source Files]
    B[RAW Layer]
    C[dbt Staging Models]
    D[dbt Intermediate Models]
    E[Fact & Dimension Models]
    F[Reporting Layer]

    A --> B
    B --> C
    C --> D
    D --> E
    E --> F
```

Architecture Version 2 Notes

Implementation discoveries:

- dbt Sources became an explicit architectural layer.
- Staging responsibilities were formally defined.
- Timestamp naming standards (_ts / _dt) introduced.
- Source metadata standardization centralized in staging.
- Business logic intentionally deferred to intermediate models.


## Architecture Decisions

### ADR-001 Geography Standardization

The Geography domain is standardized in the Intermediate Layer.

Design principles:

- one row per unique combination of State, City and ZIP prefix
- city names are stored in lowercase
- Portuguese accented characters are removed using a reusable dbt macro
- representative coordinates are calculated using AVG(latitude) and AVG(longitude)
- no coordinates are inferred for missing ZIP prefixes
- business rules for geography standardization are implemented in reusable dbt macros

The standardized Geography model provides a consistent geographic reference for downstream dimensions and fact tables.

Implementation Note

The standardized Geography model is reused by other Intermediate models to provide geographic enrichment while preserving ownership of business attributes within each domain model.

### ADR-002 Surrogate Key Strategy

The dimensional model uses surrogate keys to uniquely identify business entities within the warehouse.

Design principles:

- surrogate keys are generated in the Mart layer
- surrogate keys use the `_sk` naming convention
- business keys retain their original `_id` naming
- business dimension surrogate keys are generated using `md5()`
- the Date dimension uses an integer surrogate key in `YYYYMMDD` format
- surrogate keys are independent of source system identifiers

The surrogate key strategy provides stable dimension identifiers while preserving business keys for traceability and source system integration.

Implementation Note

Fact tables reference surrogate keys (`*_sk`) rather than business keys (`*_id`). Business keys remain available in the dimensions for auditing, troubleshooting and lineage back to the source systems.

### ADR-003 Materialization Strategy

Models are materialized according to their role within the warehouse.

Design principles:

- Staging models are materialized as views
- Intermediate models are materialized as views
- Dimension models are materialized as views
- Fact models are materialized as tables

This strategy keeps transformation layers lightweight while materializing the business reporting layer for efficient querying.

Implementation Note

Fact models are materialized as tables using folder-level configuration in `dbt_project.yml`. All other layers use dbt's default view materialization.