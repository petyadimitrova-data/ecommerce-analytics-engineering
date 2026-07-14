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

## What I learned about dbt Macros

Initially I thought dbt macros were mainly a way to reduce repetitive SQL.

During implementation I realized they are much more valuable as reusable business transformations.

I implemented my first custom macro, `normalize_text()`, to standardize city names by trimming whitespace, converting text to lowercase and removing Portuguese accented characters.

This allowed the business models to remain easy to read while keeping the transformation logic in a single reusable location.

I also learned that inspecting the compiled SQL is one of the best ways to debug dbt macros and understand how Jinja generates the final SQL executed by the database.

## What I learned about reusable Intermediate models

Building the Geography model first made implementing the Customer model much simpler.

Instead of duplicating geography transformations, the Customer model reuses the standardized Geography model and only enriches the customer records with latitude and longitude.

This reinforced the idea that Intermediate models should encapsulate reusable business logic and serve as building blocks for other models.

It also highlighted the importance of clearly defining ownership between models. The Customer model remains the owner of customer attributes, while the Geography model provides reusable geographic enrichment.

## What I learned about defining the grain

During implementation I discovered that the Orders and Order Items datasets are stored at different levels of detail.

The Orders dataset contains one record per order, while the Order Items dataset contains one record per purchased item.

At first I assumed `order_item_id` represented quantity, but after exploring the data I realized it identifies individual order lines.

This reinforced the importance of understanding the grain of each dataset before designing downstream models. The business meaning of a table cannot always be inferred from column names alone.

## What I learned about the role of the Intermediate layer

At the beginning of the project, I thought the Intermediate layer was mainly where data from different staging models would be joined together.

During implementation I realized that joins are only one possible transformation.

The real purpose of the Intermediate layer is to provide stable business models for downstream layers. Some models enrich data by joining multiple sources, while others simply expose a clean, reusable business entity.

This changed the way I think about the Intermediate layer. It is not defined by the type of SQL it contains, but by the role it plays within the warehouse architecture.

### What I Learned About Feature Branches

During the early stages of the project, I continued several implementation phases within the same feature branch. While this simplified development initially, the branch gradually accumulated multiple completed milestones and no longer accurately reflected the scope of work.

This experience reinforced the importance of aligning feature branches with meaningful units of delivery rather than allowing them to grow throughout the project.

Going forward, each major implementation phase will be developed in its own dedicated feature branch, merged into `main` after completion, and retired before the next phase begins.

This approach provides:

* Clearer project history
* Smaller, reviewable units of work
* Better traceability of implementation milestones
* A workflow that more closely reflects professional software engineering practices

---

# Phase 5 - Dimensional Models

## What I learned about surrogate keys

While implementing the first dimension, I learned that surrogate keys are warehouse-generated identifiers that are independent of the source system.

Initially I focused only on generating unique values. During implementation I also learned that concatenating business attributes should include explicit separators before hashing.

Using separators makes the generated key unambiguous and follows a common best practice for surrogate key generation.

I also learned that surrogate keys belong to the dimensional model rather than the source data and provide stable identifiers for downstream fact tables.

## What I learned about the Date dimension

Initially I assumed the Date dimension should contain separate columns for each business date, such as purchase date, delivery date and review date.

During implementation I realized that a Date dimension represents only one business entity: a calendar date.

The same Date dimension can then be reused multiple times by different fact tables, with each foreign key representing a different business event.

For example:

- Purchase Date
- Approval Date
- Shipping Limit Date
- Delivery Date
- Review Creation Date

all reference the same Date dimension.

This introduced me to the concept of a role-playing dimension, one of the fundamental design patterns in dimensional modeling.

## What I learned about naming surrogate keys

While designing the dimensions, I decided to distinguish surrogate keys from business keys using explicit naming.

Business keys retain their original `_id` suffix while warehouse-generated surrogate keys use the `_sk` suffix.

This convention makes it immediately clear whether a column originates from the source system or is generated within the warehouse.

## What I learned about business keys

While building the Customer dimension, I initially questioned why the source system contained both `customer_id` and `customer_unique_id`.

During implementation I learned that `customer_id` and `customer_unique_id` represent different business concepts.

`customer_id` identifies the customer record for a specific order, while `customer_unique_id` identifies the actual customer.

This means one customer can have multiple `customer_id` values if they place multiple orders.

This distinction allows the warehouse to answer both operational questions about individual orders and business questions about unique customers.

For example:

- How many unique customers purchased last year?
- How many purchases has a particular customer made?
- How many repeat customers do we have?

This reinforced that understanding the business meaning of source keys is just as important as understanding their technical implementation.

## What I learned about fact table grain

While building the first fact table, I learned that the grain of a fact table determines both its measures and its relationships to dimensions.

Because the grain of `fct_order_line` is one row per order item, no aggregation is required during loading. Each row already represents a single business event.

This reinforced that defining the grain before writing SQL makes the implementation significantly simpler and helps avoid incorrect aggregations.

## What I learned about fact table measures

Initially I thought `order_item_id` could be used to represent the quantity purchased.

During implementation I realized that `order_item_id` identifies the order line, not the quantity itself.

In the Olist dataset each order line represents one purchased unit, so adding an explicit `quantity` measure makes the fact table easier to understand and simpler to use in reports.

## What I learned about building the first star schema

Building `fct_order_line` demonstrated how the different warehouse layers work together.

The Intermediate layer prepares reusable business data, the Dimension layer provides descriptive business entities, and the Fact layer records business events by referencing dimensions through surrogate keys.

This was the first point in the project where the complete dimensional model came together as a star schema.

## What I learned about business dates

While building the Review models, I discovered that a column name does not always match the actual data type.

Although `review_creation_dt` looked like a business date, it was actually stored as a timestamp.

To keep the Intermediate layer consistent, I exposed both the original timestamp (`review_creation_ts`) and the business date (`review_creation_dt`).

This reinforced the importance of validating the source data instead of relying only on column names.


---

# Phase 5 Lessons Learned

I would add one more lesson from today.

```markdown
## What I learned about business reality in a warehouse

While validating the Delivery Performance fact, I found that some orders did not have a delivery date.

At first this looked like a data quality issue, but it actually reflected the business process—those orders had not yet been delivered.

This reinforced that good validation is not about eliminating every NULL value. It is about confirming that the warehouse correctly represents the underlying business reality.

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