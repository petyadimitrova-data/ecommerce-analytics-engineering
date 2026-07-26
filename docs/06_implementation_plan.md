## Question Answered:
In what order will the solution be built?
What technology stack is used to implement the solution?

## Purpose:
Document the implementation roadmap, key delivery milestones, and the technology stack used throughout the project.


## Technology Stack

Data Warehouse:
- DuckDB

Transformation Framework:
- dbt

Version Control:
- Git/GitHub

Reporting:
- Power BI (planned)

## Implementation Phases

### Phase 1 - Data Ingestion

- Load source files into the RAW layer
- Validate row counts and source completeness

### Phase 2 - dbt Initialization

- Configure the dbt project
- Set up the local development environment
- Configure DuckDB connection

### Phase 3 - Staging

- Standardize naming conventions
- Apply basic data cleansing
- Create source-aligned staging models

### Phase 4 - Intermediate

- Create reusable business logic models
- Prepare data for dimensional modeling

### Phase 5 - Dimensional Models

- Build dimensions
- Build fact tables
- Validate relationships

### Phase 6 - Data Quality

- Implement generic dbt tests
- Implement custom business rule tests
- Validate model integrity

### Phase 7 - Documentation

- Document models and lineage
- Document architecture and design decisions
- Document deployment strategy
- Document lessons learned

---

# Project Evolution

During the implementation of this project, the roadmap evolved to better reflect the natural Analytics Engineering workflow.

The initial plan separated implementation, testing, repository polish, and reporting into individual project stages. As development progressed, testing became an integral part of the Analytics Engineering implementation through automated dbt testing, while repository organization was completed alongside the engineering work.

The final project structure was simplified to better represent the completed solution.

## Final Roadmap (23-Jul-2026)

```text
01 - Project Management
Planning
Requirements
Architecture
Scope

↓

02 - Data Model Design
Business Understanding
Kimball Modeling
Metrics
Grain
Relationships

↓

03 - Analytics Engineering Implementation

Everything technical.

DuckDB
dbt
SQL
Staging
Intermediate
Facts
Dimensions
Tests
Documentation
Deployment

↓

04 - Dashboard & Reporting
The business outcome.
```

The reporting phase is intentionally separated from the Analytics Engineering implementation to emphasize the distinction between building a trusted analytical data model and delivering business insights through dashboards and visualizations.

### Metric Implementation

Not every business metric requires a dedicated DAX measure.

Many business metrics are different analytical perspectives of the same reusable business calculation.

Examples:

- Total Revenue → dedicated DAX measure
- Revenue by Product Category → Total Revenue + Product Category dimension
- Revenue by Seller → Total Revenue + Seller dimension
- Customer Lifetime Value → Total Revenue + Customer dimension