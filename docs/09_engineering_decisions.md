# ADR-001 - Geography Standardization

## Status

Approved

---

## Context

The Olist dataset contains multiple representations of identical cities.

Example

- sao paulo
- são paulo

Profiling showed that both representations belong to the same geographic location.

Average coordinate difference:

Approximately 24 meters.

The project also requires map visualizations in the reporting layer.

Therefore a standardized geography model is required.

---

## Decision

The Intermediate Geography model will become the reusable standardized geography dataset.

Responsibilities:

- one row per ZIP prefix
- standardized city names
- preserve state
- representative coordinates
- reusable across dimensions

---

## City Standard

City names will be stored using

- lowercase
- accent-free characters
- trimmed values

Example

São Paulo

↓

sao paulo

---

## Coordinate Aggregation

Multiple coordinate observations for the same ZIP prefix will be represented using

AVG(latitude)

AVG(longitude)

This approximates the centroid of the ZIP area.

---

## Missing Geography

If coordinates are unavailable

Latitude = NULL

Longitude = NULL

No coordinate interpolation or estimation will be performed.

---

## Rationale

This approach

- improves reporting consistency
- removes encoding issues
- improves joins
- simplifies downstream reporting
- preserves source integrity

---

## Consequences

Benefits

- reusable geography dataset
- deterministic reporting
- simplified dimensional modelling

Trade-offs

- official accented spelling is not preserved
- presentation layer may choose alternative display names in the future

Data profiling demonstrated that
ZIP prefix alone is not a unique business identifier.

Approximately 555 ZIP prefixes
are associated with more than one city/state combination.

Therefore the Geography business key becomes

(State, City, ZIP Prefix)

rather than ZIP Prefix alone. The Geography surrogate key is generated from the combination of State, City, and ZIP Prefix.

Additional Profiling Findings

Further profiling of the standardized geography model identified that
ZIP prefixes are not globally unique.

Findings

• 550 ZIP prefixes belong to multiple cities.
• 8 ZIP prefixes belong to multiple states.
• No duplicate records exist for the combination
  (State, City, ZIP Prefix).

Decision

The geography grain for the warehouse becomes

(State, City, ZIP Prefix)

rather than ZIP Prefix alone.