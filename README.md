# E-commerce Analytics Engineering Project

An end-to-end Analytics Engineering portfolio project built using the Brazilian Olist E-commerce dataset.

The objective of this project is to demonstrate modern Analytics Engineering practices, including dimensional modeling, dbt development, automated data quality testing, semantic modeling, Power BI reporting, documentation, and Git-based version control.

---

# Project Goals

Build a production-style Analytics Engineering solution that demonstrates:

- Modern layered architecture
- Reusable dbt transformations
- Kimball dimensional modeling
- Automated data quality testing
- Semantic modeling in Power BI
- Interactive business reporting
- Documentation and lineage
- Git-based development workflow

---

# Technology Stack

- DuckDB
- dbt Core
- SQL
- Power BI
- Git & GitHub
- DBeaver

---

# Key Features

- End-to-end Analytics Engineering workflow
- Kimball dimensional modeling
- Layered dbt architecture (Staging → Intermediate → Marts)
- Automated data quality testing (97 tests)
- Power BI semantic model
- Interactive business reporting
- Comprehensive project documentation
- Git feature branch development workflow

---

# Architecture

```
CSV Source Files
        │
        ▼
DuckDB Analytics Warehouse
        │
        ▼
dbt Transformation Layer
        │
        ▼
Kimball Dimensional Model
        │
        ▼
Power BI Semantic Model
        │
        ▼
Business Dashboards
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
duckdb/
powerbi/
scripts/
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

#### Dimensions

- dim_customer
- dim_date
- dim_geography
- dim_product
- dim_seller

#### Facts

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

### Power BI Reporting

- Connected Power BI directly to the DuckDB warehouse
- Configured star schema semantic model
- Business-friendly table and column names
- Hidden technical implementation fields
- Foundational DAX business measures
- Reporting architecture established

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

Designing reusable models, choosing the appropriate layer for business logic, documenting architectural decisions, implementing semantic models, and balancing enterprise patterns with portfolio-scale solutions have all been valuable learning experiences.

---

# Current Status

🚧 Dashboard & Reporting (In Progress)

## Completed

- Data ingestion
- Layered dbt architecture
- Dimensional warehouse
- Automated data quality testing
- Engineering documentation
- dbt Docs and lineage
- Power BI environment
- Power BI semantic model
- Foundational DAX measures

## In Progress

- Business KPI development
- Interactive dashboards
- Executive reporting

## Remaining

- Dashboard refinement
- Final documentation polish
- Portfolio completion

---

# Future Improvements

- Semantic metrics layer
- Additional business marts
- CI/CD pipeline
- Automated deployment
- Containerized development environment

---

# Author

**Petya Dimitrova**

Analytics Engineering Portfolio Project