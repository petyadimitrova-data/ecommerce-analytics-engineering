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