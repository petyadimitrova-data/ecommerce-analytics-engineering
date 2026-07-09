# Lessons Learned

## Purpose

Capture key learnings, observations, challenges, and retrospective insights throughout the implementation of the Analytics Engineering Portfolio project.

## Question This Document Answers

* What was learned during each implementation phase?
* What implementation decisions proved valuable?
* What would be done differently in a future project?

## Audience

* Project Author
* Hiring Managers
* Analytics Engineers
* Future Project Maintainers

## Related Documents

* implementation_plan.md
* architecture.md
* deployment_strategy.md

---

# Phase 1 - Data Ingestion

## What I Learned

### Why we switched from Snowflake to DuckDB

The original implementation plan assumed Snowflake would be used as the analytical warehouse.

After the Snowflake trial environment required payment method verification, the project was re-evaluated from a portfolio perspective.

This led to an important realization:

The primary objective of the project is to demonstrate Analytics Engineering capabilities rather than proficiency with a specific warehouse technology.

DuckDB was selected because it provides:

* Local execution
* No infrastructure costs
* Fast analytical performance
* Native SQL support
* Excellent dbt integration

The switch allowed the project to remain focused on Analytics Engineering concepts rather than cloud platform administration.

### What I Learned About GitHub

Prior experience involved working with dbt projects stored in Azure DevOps repositories.

This project provided hands-on experience with:

* Creating personal repositories
* Cloning repositories locally
* Creating feature branches
* Managing commits
* Pushing changes to GitHub
* Repository organization for public portfolio projects

A key takeaway was understanding the relationship between:

```text
Local Repository
    ↓
Commit
    ↓
Push
    ↓
GitHub Repository
```

### What I Would Do Differently Next Time

1. Establish repository structure before loading data.
2. Define documentation standards at project initiation.
3. Create implementation checkpoints from the beginning.
4. Configure Git and GitHub workflow before starting technical work.

---

# Phase 2 - dbt Project Initialization

## What I Learned

### What I Learned About Local Analytics Engineering Environments

Most of my previous experience was with managed platforms such as Snowflake and dbt Cloud where the underlying infrastructure is largely abstracted away.

This implementation highlighted the components required to build a local Analytics Engineering environment from scratch:

* Local database engine (DuckDB)
* Database client (DBeaver)
* Python runtime
* Python virtual environments
* dbt Core
* Warehouse connection configuration
* Git-integrated development workflow

The experience helped me better understand how the various components interact behind the scenes in a dbt Core project.

### What I Learned About DuckDB

DuckDB proved to be a practical warehouse choice for portfolio development because it provides:

* Simple local installation
* Fast analytical query performance
* Native SQL support
* Easy integration with dbt
* Portable database files

Using DuckDB allowed me to focus on Analytics Engineering concepts without relying on cloud infrastructure or incurring platform costs.

### What I Learned About dbt Core vs dbt Cloud

My previous hands-on experience was primarily with dbt Cloud.

Working with dbt Core exposed several components that are normally hidden by the Cloud platform:

* Python environment management
* Adapter installation
* Profile configuration
* Project initialization
* Warehouse connectivity
* Local execution environment

The experience improved my understanding of the underlying architecture that supports dbt Cloud projects.

### What I Learned About Python Virtual Environments

Project-specific virtual environments provide a reproducible and isolated development setup.

Benefits observed during implementation:

* Dependency isolation
* Consistent package versions
* Reduced risk of conflicts between projects
* Easier environment recreation

This approach aligns with software engineering best practices and is particularly valuable when working with dbt Core.

### What I Would Do Differently Next Time

1. Install Python and create a virtual environment before installing dbt.
2. Configure DBeaver before beginning implementation.
3. Define local development tooling standards upfront.
4. Document environment setup decisions earlier in the project.
5. Create a standard project bootstrap checklist.

---

# Phase 3 - Staging Models

## What I Learned

### What I Learned About Python Virtual Environments

Python virtual environments are session-specific. After reopening a terminal or restarting the machine, the virtual environment must be reactivated before using dbt.

Forgetting to reactivate the environment can result in using a different global Python installation, leading to confusing version mismatches or missing package dependencies.

This reinforced the importance of treating the virtual environment as an essential part of the daily Analytics Engineering workflow rather than a one-time project setup step.

---

### What I Learned About Staging Models

Building the staging layer reinforced that its primary responsibility is **source standardization** rather than business transformation.

During implementation I established consistent naming conventions, corrected source metadata inconsistencies (such as spelling mistakes), and standardized timestamp semantics while intentionally avoiding:

* Business logic
* Joins
* Aggregations
* Surrogate key generation
* Business metric calculations

One important design decision was to preserve source granularity.

Instead of transforming timestamps into dates early in the pipeline, I retained the original level of detail and deferred business-specific interpretations to downstream models. This keeps the staging layer reusable and allows fact and dimension models to apply business rules without losing source information.

Another valuable lesson was that **consistency across models is more valuable than optimizing each model individually**.

Establishing common conventions before implementing all staging models resulted in a cleaner, more maintainable, and easier-to-understand Analytics Engineering codebase.


---

# Phase 4 - Intermediate Models

## What I learned about designing reusable business models

At first I assumed the Geography model could be built directly from the source tables.

While exploring the source data in more detail, I discovered several inconsistencies that needed to be addressed before building downstream dimensions.

Some of the findings included:

- the same city stored with different spellings (for example, "sao paulo" and "são paulo")
- multiple coordinate records for the same location
- ZIP prefixes that belonged to more than one city
- a small number of ZIP prefixes that appeared in more than one state

Initially I assumed that ZIP prefix uniquely identified a geographic location. After validating the data, I realized this assumption was incorrect.

Instead of forcing the data to fit the original design, I updated the model grain to use the combination of State, City and ZIP Prefix.

One of the biggest lessons for me was that data models should be designed based on how the data actually behaves, not on initial assumptions.

This resulted in a cleaner and more reliable warehouse design.

---

## What I learned about dbt Macros

Initially I thought dbt macros were mainly a way to reduce repetitive SQL.

During implementation I realized they are much more valuable as reusable business transformations.

I implemented my first custom macro, `normalize_text()`, to standardize city names by trimming whitespace, converting text to lowercase and removing Portuguese accented characters.

This allowed the business models to remain easy to read while keeping the transformation logic in a single reusable location.

I also learned that inspecting the compiled SQL is one of the best ways to debug dbt macros and understand how Jinja generates the final SQL executed by the database.

---

# Phase 5 - Dimensional Models

*To be completed.*

---

# Phase 6 - Data Quality

*To be completed.*

---

# Phase 7 - Documentation

*To be completed.*

---

# Phase 8 - Reporting

*To be completed.*
# End-of-Project Retrospective

_To be completed after project delivery._

Topics to revisit:

- Working with AI as a brainstorming partner
- Architecture decisions and project context
- Enterprise patterns vs portfolio project patterns
- Building a local Analytics Engineering environment
- Planned architecture vs implemented architecture
- What would be done differently in Project #2