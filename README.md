# E-commerce Analytics Engineering Project

An end-to-end Analytics Engineering portfolio project built using the Brazilian Olist E-commerce dataset.

The objective of this project is to demonstrate modern Analytics Engineering practices, including dimensional modeling, dbt development, automated data quality testing, documentation, and Git-based version control.

---

# Project Goals

Build a production-style analytics warehouse that demonstrates:

- Modern layered architecture
- Reusable dbt transformations
- Kimball dimensional modeling
- Automated data quality testing
- Documentation and lineage
- Git-based development workflow

---

# Technology Stack

- DuckDB
- dbt Core
- SQL
- Git & GitHub
- DBeaver

---

# Key Features

- End-to-end Analytics Engineering workflow
- Kimball dimensional modeling
- Layered dbt architecture (Staging → Intermediate → Marts)
- Automated data quality testing (97 tests)
- Comprehensive project documentation
- Git feature branch development workflow

---

# Architecture

```
Raw Sources
      │
      ▼
 Staging Layer
      │
      ▼
Intermediate Layer
      │
      ▼
Dimensional Models
      │
      ▼
Business Reporting
```

---

# Project Structure

```
dbt/
│
├── staging/
├── intermediate/
├── marts/
│   ├── dimensions/
│   └── facts/
│
├── macros/
├── tests/
├── snapshots/
└── seeds/

docs/
scripts/
duckdb/
```

---

# Current Progress

## ✅ Completed

### Data Ingestion

- RAW data ingestion
- Source registration in dbt

### Staging Layer

- Nine staging models
- Source standardization
- Naming conventions
- Metadata cleanup

### Intermediate Layer

- Reusable business models
- Geography standardization
- Shared enrichment logic
- Custom dbt macro

### Dimensional Warehouse

Dimensions

- dim_customer
- dim_date
- dim_geography
- dim_product
- dim_seller

Facts

- fct_order_line
- fct_payment
- fct_review
- fct_delivery_performance

### Data Quality

- Generic dbt tests
- Custom business rule tests
- Relationship tests
- Model documentation
- dbt Docs
- Model lineage
- 97 automated tests passing

---

# Repository Documentation

The `/docs` directory contains the project's engineering documentation, including:

- Business Requirements
- Metric Definitions
- Data Model Design
- Architecture
- Implementation Plan
- Data Quality
- Architecture Decision Records (ADRs)
- Developer Guide
- Engineering Decisions
- Lessons Learned
- Source Validation
- dbt Macros

---

# Lessons Learned

One of the biggest takeaways from this project has been learning that Analytics Engineering is as much about architecture and engineering decisions as it is about SQL.

Designing reusable models, choosing the right level for business logic, documenting decisions, and balancing enterprise patterns with project scale have all been valuable learning experiences.

---

# Current Status

🚧 Final Project Polish

Completed:

- Data ingestion
- Layered dbt architecture
- Dimensional warehouse
- Automated data quality testing
- Documentation
- dbt Docs

Remaining work:

- Reporting layer
- Interactive dashboards
- Final documentation polish

---

# Future Improvements

- Semantic metrics layer
- Additional business marts
- CI/CD pipeline
- Automated deployment
- Containerized development environment

---

# Author

Petya Dimitrova

Analytics Engineering Portfolio Project
