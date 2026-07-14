# Data Model Design

## Question Answered:

What dimensional model best supports the business processes and analytical requirements of the e-commerce platform?

## Purpose

Define the analytical data model that supports the business requirements and metric definitions.

## Key Decisions

- Fact table grain
- Dimension design
- Business process coverage
- Fact-to-dimension relationships

# Candidate Dimensions

## dim_customer

Business Purpose:
Represents marketplace customers purchasing products through Olist.

Primary Key:

* customer_sk (surrogate key)

Business Key:

* customer_unique_id (to validate it)

Relationships:

* geography_sk → dim_geography

Candidate Attributes:

* customer_unique_id

---

## dim_seller

Business Purpose:
Represents merchants selling products through the marketplace.

Primary Key:

* seller_sk

Business Key:

* seller_id

Relationships:

* geography_sk → dim_geography

Candidate Attributes:

* seller_id

---

## dim_geography

Business Purpose:
Reusable conformed dimension providing geographical enrichment for customers and sellers.

Primary Key:

* geography_sk

Business Key:

* zip_code_prefix

Candidate Attributes:

* zip_code_prefix
* city
* state
* latitude
* longitude

---

## dim_product

Business Purpose:
Represents products sold on the marketplace.

Primary Key:

* product_sk

Business Key:

* product_id

Candidate Attributes:

* category_name_english

Listing Attributes:

* product_name_length
* product_description_length
* product_photos_qty

Physical Attributes:

* product_weight_g
* product_length_cm
* product_height_cm
* product_width_cm

---

## dim_date

Business Purpose:
Calendar dimension used for reporting and time-based analysis.

Primary Key:

* date_sk

Candidate Attributes:

* calendar_date
* day
* month
* quarter
* year
* week
* day_of_week
* month_name
* quarter_name

---
## Open Modeling Decisions

Customer Business Key
* Assumption:
customer_unique_id represents the actual business customer.

* Validation Required:
Confirm relationship between customer_id and customer_unique_id.

Geography Modeling

* Decision:
Create reusable dim_geography.

* Rationale:
Geographical attributes are shared by customers and sellers and support future geospatial analysis.

Product Category

* Decision:
Store translated category name within dim_product.

* Rationale:
Translation table acts as reference data and does not justify a standalone dimension.

---

# Candidate Fact Tables

## fct_order_line

Business Process:
Customer purchases product(s) through the marketplace.

Grain:
One row per order item.

Source Tables:

* olist_order_items_dataset

Measures:

* price
* freight_value

Dimensions:

* dim_customer
* dim_product
* dim_seller
* dim_date

Purpose:
Primary commercial fact supporting revenue, order volume, product performance, seller performance, and customer analytics.

---

## fct_payment

Business Process:
Customer payment transactions.

Grain:
One row per payment transaction.

Source Tables:

* olist_order_payments_dataset

Measures:

* payment_value

Dimensions:

* dim_customer
* dim_date

Purpose:
Supports payment analysis, payment method analysis, and payment value reporting.

Open Questions:

* Validate relationship between orders and payments.
* Confirm whether multiple payment transactions can exist for a single order.

---

## fct_delivery_performance

Business Process:
Order fulfillment and delivery lifecycle.

Grain:
One row per order.

Source Tables:

* olist_orders_dataset

Derived Measures:

* approval_time
* shipping_time
* delivery_time
* delivery_delay

Dimensions:

* dim_customer
* dim_geography
* dim_date

Purpose:
Supports logistics and fulfillment analysis, including delivery performance and on-time delivery metrics.

Open Questions:

* Validate calculation logic for approval, shipping, and delivery durations.
* Determine whether additional seller-level delivery analysis is required.

---

## fct_review

Business Process:
Customer feedback and satisfaction.

Grain:
One row per review.

Source Tables:

* olist_order_reviews_dataset

Measures:

* review_score

Dimensions:

* dim_customer
* dim_product
* dim_seller
* dim_date

Purpose:
Supports customer satisfaction analysis, review trends, seller ratings, and product ratings.

Open Questions:

* Validate review-to-order relationship.
* Confirm whether multiple reviews can exist for a single order.

---

# Preliminary Star Schema

Core Dimensions:

* dim_customer
* dim_seller
* dim_product
* dim_geography
* dim_date

Core Facts:

* fct_order_line
* fct_payment
* fct_delivery_performance
* fct_review

Modeling Philosophy:

The dimensional model is organized around key marketplace business processes:

* Purchasing
* Payment
* Fulfillment
* Customer Satisfaction

The model follows a business-process-driven approach where fact tables represent measurable business events and dimensions provide descriptive context for analysis.
