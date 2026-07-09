# dbt Macros

This document describes the reusable dbt macros implemented throughout the project.

The goal of these macros is to centralize reusable business transformations, improve model readability and avoid duplicating SQL logic across multiple models.

---

# normalize_text()

## Purpose

Standardize textual values before they are used in downstream models.

The macro was initially introduced to standardize Brazilian city names within the Geography domain but is designed to be reusable across the warehouse.

Current transformations include:

- trim leading and trailing whitespace
- convert text to lowercase
- remove Portuguese accented characters

Example:

| Original | Normalized |
|----------|------------|
| São Paulo | sao paulo |
| João Pessoa | joao pessoa |
| CURITIBA | curitiba |

---

## Why a dbt Macro?

Without a reusable macro, every model requiring standardized text would need to duplicate the same SQL transformation.

Using a macro provides several advantages:

- single implementation of the business rule
- improved readability of business models
- easier maintenance
- consistent text standardization across the warehouse

Instead of embedding multiple nested `REPLACE()` functions directly in every model, the transformation can be expressed as:

```sql
{{ normalize_text("city") }}
```

which keeps the business models focused on business logic rather than implementation details.

---

## Current Usage

The macro is currently used by:

- `int_geography`

Additional Intermediate models may reuse this macro as needed.

---

## Future Enhancements

Possible future improvements include:

- collapsing multiple spaces into a single space
- removing punctuation where appropriate
- supporting additional accented character sets
- extending the macro for broader multilingual datasets