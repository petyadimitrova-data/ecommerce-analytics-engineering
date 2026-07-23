# Data Quality Strategy

The project uses a combination of dbt generic tests and custom business rule tests to validate both structural integrity and business correctness.

## Generic Tests

The following built-in dbt tests are implemented:

- unique
- not_null
- relationships

These tests validate key integrity, mandatory fields, and referential consistency across the dimensional model.

## Custom Business Rule Tests

Custom SQL tests validate business-specific rules, including:

- Product prices are non-negative.
- Payment values are non-negative.
- Review scores are between 1 and 5.
- Delivery days are non-negative.
- Approval days are non-negative.
- Order line quantity equals one.

All tests are executed automatically as part of the project build using:

```bash
dbt build