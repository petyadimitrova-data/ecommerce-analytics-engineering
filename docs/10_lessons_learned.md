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

## What I learned aout business reality in a warehouse

While validating the Delivery Performance fact, I found that some orders did not have a delivery date.

At first this looked like a data quality issue, but it actually reflected the business process—those orders had not yet been delivered.

This reinforced that good validation is not about eliminating every NULL value. It is about confirming that the warehouse correctly represents the underlying business reality.

---

# Phase 6 - Documentation

## What I learned about documenting engineering decisions

At the beginning of the project, I viewed documentation as something that would be written after the implementation was complete.

As the project progressed, I realized that documenting design decisions while they were still fresh made the documentation significantly more accurate and easier to maintain.

Keeping architecture documents, implementation notes, and lessons learned up to date throughout the project meant that the final documentation required only minor refinement instead of a complete rewrite.

This reinforced that documentation should be treated as part of the engineering process rather than a final deliverable.

---

## Project Structure Should Evolve with the Solution

One unexpected lesson from this project was that the original roadmap was not the final roadmap.

At the beginning, implementation, testing, repository polish, and reporting were planned as separate project stages. As development progressed, it became clear that data quality testing was an integral part of the Analytics Engineering implementation rather than a standalone phase. Likewise, repository organization and documentation naturally evolved throughout the project instead of being completed at the end.

Rather than following the original plan rigidly, the project structure was simplified to better represent the completed solution.

Final project structure:

- Project Management
- Data Model Design
- Analytics Engineering Implementation
- Dashboard & Reporting

This experience reinforced that project plans should guide implementation, not constrain it. As understanding improves, the roadmap should evolve to reflect the solution rather than the original assumptions.

# Final Project Retrospective

## What I learned about Analytics Engineering

Before starting this project, my understanding of Analytics Engineering was largely based on individual concepts such as SQL, dbt, and dimensional modeling.

Building a complete end-to-end solution showed me that Analytics Engineering is the combination of many complementary disciplines rather than a single technology.

It includes data modeling, transformation design, testing, documentation, version control, deployment strategy, and an understanding of business requirements.

The project demonstrated that producing reliable analytical data is not only about writing SQL—it is about designing systems that are understandable, maintainable, and trusted by their users.

This project significantly changed how I think about Analytics Engineering and provided a much deeper appreciation for the engineering practices behind modern analytics platforms.


Completing this project provided a much deeper understanding of Analytics Engineering than I initially expected.

Beyond learning individual technologies such as DuckDB and dbt, the project demonstrated how planning, data modeling, implementation, testing, documentation, and version control work together to create a reliable analytical solution.

Several key reflections stand out.

## Working with AI as an Engineering Partner

One of the biggest takeaways was learning how to collaborate effectively with AI throughout an engineering project.

Rather than treating AI as a code generator, I found the greatest value in using it as a brainstorming partner, design reviewer, and quality assurance resource.

As my confidence grew, the collaboration naturally shifted from asking "How do I build this?" to asking "Does this implementation make sense?" and "Can this design be improved?"

This approach helped me better understand the reasoning behind engineering decisions instead of simply producing working code.

---

## Enterprise Patterns vs Portfolio Projects

Working on a portfolio project highlighted the difference between demonstrating technical capability and replicating an enterprise environment.

Many enterprise practices—such as layered architectures, documentation standards, naming conventions, testing, and Git workflows—translated directly into the project.

At the same time, local tools such as DuckDB made it possible to focus on Analytics Engineering concepts without the complexity of cloud infrastructure.

---

## Building a Local Analytics Engineering Environment

Creating a complete local development environment provided valuable insight into the technologies that support modern Analytics Engineering.

Managing Python virtual environments, configuring dbt Core, connecting DuckDB, using DBeaver, and integrating GitHub provided a much deeper understanding than working exclusively in managed cloud platforms.

---

## Planned Architecture vs Implemented Architecture

Although the project began with a detailed implementation plan, several architectural decisions evolved during development.

Examples included refining the Geography model grain, improving reusable Intermediate models, integrating testing into the implementation process, and simplifying the overall project roadmap.

This reinforced that good architecture is iterative and should evolve as understanding of the data improves.

---

## Looking Ahead to Project #2

For the next Analytics Engineering project, I plan to take a more independent implementation approach.

Rather than relying on AI for initial design decisions, I intend to develop the architecture and implementation myself before using AI primarily as a reviewer for quality assurance, design validation, and constructive feedback.

This should strengthen my own engineering decision-making while still benefiting from independent review.

---

## Final Reflection

This project successfully achieved its primary objective: demonstrating an end-to-end Analytics Engineering workflow while significantly deepening my understanding of the discipline.

More importantly, it reinforced that Analytics Engineering is not defined by a single technology. It is the combination of data modeling, transformation design, testing, documentation, deployment practices, and continuous learning that creates reliable analytical systems.

Project Structure Should Evolve with the Solution.

### Power BI Custom Connector Location

When using custom Power Query connectors (.mez), Power BI may look for the
`Power BI Desktop\Custom Connectors` folder under the OneDrive Documents directory
instead of the local Documents folder.

On systems where Windows redirects the Documents library to OneDrive, placing the
connector under:

C:\Users\<User>\OneDrive\Documents\Power BI Desktop\Custom Connectors

allowed Power BI to successfully discover the custom DuckDB connector.

This is an environment-specific configuration that may not be obvious from the installation guide.


Automatic relationship detection should never be blindly trusted in a dimensional model.

## Reporting Phase

### DAX is a Transformation Language

One of the biggest conceptual shifts was understanding that DAX is not a collection of independent functions. Instead, measures are built as a sequence of transformations, where each function transforms a table or value into the next step of the business calculation.

This perspective made complex measures easier to reason about by focusing on the intermediate result rather than individual functions.

### Business Grain Before DAX

Several calculations depended on selecting the correct business identifier before writing any DAX.

For example, Repeat Customer Rate must be calculated using `customer_unique_id` rather than the technical surrogate key `customer_sk`.

The business grain should always be validated before implementation.

### SQL as the Bridge to DAX

Translating the business problem into SQL first significantly simplified the DAX implementation.

Rather than learning DAX syntax directly, implementing the SQL logic step by step made the DAX expressions easier to understand and validate.