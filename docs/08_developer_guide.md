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

* 05_architecture.md
* 06_implementation_plan.md
* 07_deployment_strategy.md

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

## 4. Verify the Active Git Branch

Before beginning development, verify that you are working on the intended feature branch and that the working tree is clean.

Check the active branch:

```bash
git branch
```

Example:

```text
* feature/<feature-name>
  main
```

The active branch is indicated by the `*` symbol.

Verify the repository status:

```bash
git status
```

Expected result:

```text
On branch feature/<feature-name>

nothing to commit, working tree clean
```

---

## 5. Validate the Environment

```bash
dbt debug
```

Expected result:

```text
All checks passed
```

---

## 6. Begin Development

Edit SQL models under:

```text
models/
```

---

## 7. Build Models

Build the entire project:

```bash
dbt run
```

Build a single model:

```bash
dbt run --select stg_orders
```

---

## 8. Validate Results

Review the generated models in DuckDB using DBeaver.

Validation checklist:

* View creation
* Row counts
* Column names
* Sample data
* Data quality

---

## 9. Commit Changes

```bash
git add .

git commit -m "Meaningful commit message"

git push
```

---

# Branch Strategy

Development is performed using dedicated feature branches.

Typical workflow:

1. Create a feature branch from `main`.
2. Verify the active branch before beginning development.
3. Implement the planned changes.
4. Commit changes locally using meaningful commit messages.
5. Push the feature branch to GitHub.
6. Open a Pull Request.
7. Merge the Pull Request into `main` after the implementation milestone has been completed and validated.
8. Delete the feature branch both remotely and locally.
9. Create the next feature branch from the updated `main`.

---

# Development Principles

* One source table → One staging model
* Preserve source granularity
* Standardize source naming
* Avoid business logic in the staging layer
* Keep models focused on a single responsibility
* Validate changes before committing

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