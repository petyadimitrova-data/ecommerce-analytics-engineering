# Lessons Learned

## Purpose

Capture the key technical, architectural, and professional lessons learned throughout the implementation of this Analytics Engineering portfolio project.

This document focuses on the engineering decisions, design principles, and practical experience gained while building an end-to-end analytical solution.

---

# Business Understanding

One of the earliest lessons was that successful Analytics Engineering begins with understanding the business problem rather than the technology.

Defining business domains, identifying key business processes, documenting analytical requirements, and agreeing on metric definitions before implementation provided a clear direction for the entire project.

Throughout development, every modeling and implementation decision could be traced back to a documented business requirement.

---

# Data Modeling

Building the dimensional model deepened my understanding of several fundamental Kimball modeling principles.

While analyzing the Geography data, I discovered duplicate city names, inconsistent spellings, and non-unique ZIP prefixes. Instead of forcing the original design to fit the data, the model grain was refined to use the combination of State, City, and ZIP Prefix.

Another important realization was the importance of defining the grain before writing SQL. Understanding the business event represented by each fact table simplified both implementation and validation.

The project also strengthened my understanding of surrogate keys, business keys, role-playing dimensions, and the relationship between dimensions and facts within a star schema.

---

# Analytics Engineering

Completing the project demonstrated that Analytics Engineering extends far beyond writing SQL transformations.

Building a reliable analytical platform required combining data modeling, transformation design, testing, documentation, version control, deployment planning, and business understanding into a single engineering workflow.

The project demonstrated that trusted analytics are created through engineering discipline rather than individual technologies.

---

# dbt Development

Working with dbt Core provided a much deeper understanding of modern transformation frameworks.

Several important principles emerged during implementation:

- Staging models should focus on source standardization rather than business logic.
- Intermediate models should encapsulate reusable business concepts.
- Dimensions and fact tables should expose business-ready analytical structures.
- dbt macros are valuable for implementing reusable business transformations rather than simply reducing repetitive SQL.

Developing locally with DuckDB also provided practical experience configuring Python environments, dbt profiles, adapters, and project structure outside of managed cloud platforms.

---

# Data Quality

One of the biggest takeaways was that data quality is not limited to validating technical correctness.

Generic dbt tests verified structural integrity through uniqueness, referential integrity, and mandatory fields, while custom business rule tests validated assumptions such as positive prices, valid review scores, and realistic delivery durations.

Equally important was recognizing that not every NULL value represents poor data quality. Several missing delivery dates correctly reflected orders that had not yet been delivered, showing that validation should represent business reality rather than simply eliminating missing values.

---

# Semantic Modeling & Power BI

The reporting phase highlighted the importance of separating business metrics from implementation details.

A business metric answers a business question, while a DAX measure represents a reusable business calculation that can support multiple analytical perspectives through filter context.

Approaching DAX by first expressing the business logic in SQL significantly simplified implementation and validation.

The semantic model also highlighted the importance of selecting the correct business grain. Measures such as Repeat Customer Rate depended on selecting the correct business identifier rather than the warehouse surrogate key.

One unexpected discovery was that building reports can reveal opportunities to improve the warehouse itself. Rather than compensating for missing business attributes with increasingly complex DAX, the dimensional model was enhanced to better support downstream reporting.

---

# Dashboard Design

Building the reporting layer demonstrated that effective dashboards answer business questions rather than display as many metrics as possible.

Several dashboard iterations focused on removing redundant visuals, improving page identity, and ensuring that each report answered a distinct set of business questions.

The final reporting solution evolved into four complementary dashboards:

- Executive Overview
- Commercial Performance
- Customer Analytics
- Customer Satisfaction

Each dashboard was designed to support a specific analytical conversation while sharing a consistent visual language.

---

# Enterprise Patterns vs Portfolio Projects

Working on a personal portfolio project highlighted the balance between demonstrating professional engineering practices and maintaining appropriate project scope.

Enterprise concepts such as layered architectures, documentation standards, dimensional modeling, automated testing, Git workflows, and semantic modeling translated directly into the project.

At the same time, using local technologies such as DuckDB allowed the focus to remain on Analytics Engineering concepts without introducing unnecessary infrastructure complexity.

---

# Working with AI as an Engineering Partner

One of the most valuable experiences throughout this project was learning how to collaborate effectively with AI.

Rather than treating AI as a code generator, I found the greatest value in using it as a design reviewer, brainstorming partner, quality assurance resource, and documentation editor.

As the project progressed, the collaboration naturally evolved from implementation questions toward architectural discussions, business reasoning, and design validation.

This approach encouraged me to critically evaluate every proposed solution instead of accepting it at face value. It helped me better understand the reasoning behind engineering decisions rather than simply producing working code.

---

# What I Would Do Differently

If I were starting this project again, I would:

- Establish the repository structure before implementation begins.
- Define documentation standards from the outset.
- Create Architecture Decision Records (ADRs) earlier in the project.
- Separate implementation milestones into smaller feature branches.
- Design the initial architecture independently before using AI primarily for review and validation.

These improvements would further streamline development while preserving the iterative learning process that proved valuable throughout the project.

---

# Final Reflection

This project achieved its primary objective of demonstrating an end-to-end Analytics Engineering workflow.

More importantly, it fundamentally changed how I think about Analytics Engineering.

Rather than viewing Analytics Engineering as a collection of individual tools such as SQL, dbt, or Power BI, I now see it as the discipline of designing reliable analytical systems that transform business requirements into trusted decision-making assets.

Building the complete solution - from raw data ingestion through dimensional modeling, automated testing, semantic modeling, and business reporting - provided practical experience that cannot be gained by studying individual technologies in isolation.

The project confirmed that successful Analytics Engineering is built on thoughtful design, continuous validation, clear documentation, and a deep understanding of the business problems being solved.