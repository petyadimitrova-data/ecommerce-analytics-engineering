# Developer Guide

## Purpose

Provide everything required for a developer to contribute to the project.

## Questions This Document Answers

* How do I start a development session?
* How do I build the project?
* How do I validate changes?
* What development standards should I follow?

## Audience

* Project Author
* Future Contributors

## Related Documents

* implementation_plan.md
* architecture.md
* deployment_strategy.md

---

# Starting a Development Session

## 1. Open a Terminal

Navigate to the project root.

```powershell
cd <repository_root>
```

---

## 2. Activate the Virtual Environment

```powershell
.\.venv\Scripts\Activate.ps1
```

Expected prompt:

```text
(.venv)
```

---

## 3. Navigate to the dbt Project

```powershell
cd dbt\ecommerce_analytics
```

---

## 4. Validate the Environment

```bash
dbt debug
```

Expected result:

```text
All checks passed
```

---

## 5. Begin Development

Edit SQL models under:

```text
models/
```

---

## 6. Build Models

Build the entire project:

```bash
dbt run
```

Build a single model:

```bash
dbt run --select stg_orders
```

---

## 7. Validate Results

Review the generated models in DuckDB using DBeaver.

Validation checklist:

* View creation
* Row counts
* Column names
* Sample data
* Data quality

---

## 8. Commit Changes

```bash
git add .

git commit -m "Meaningful commit message"

git push
```

---

# Branch Strategy

Development is performed using feature branches.

Typical workflow:

1. Create a feature branch.
2. Implement changes.
3. Commit locally.
4. Push the feature branch.
5. Merge into `main` after the implementation milestone has been completed and reviewed.

---

# Development Principles

* One source table → One staging model
* Preserve source granularity
* Standardize source naming
* Avoid business logic in the staging layer
* Validate before committing
* Keep models focused on a single responsibility

---

# Development Philosophy

This project follows a documentation-first approach.

Major implementation decisions should be:

* Documented
* Reviewed
* Validated
* Implemented
* Captured in Lessons Learned

The goal is not only to build an Analytics Engineering solution, but also to document the engineering decisions behind it.
