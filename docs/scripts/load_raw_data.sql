CREATE SCHEMA IF NOT EXISTS raw;

CREATE OR REPLACE TABLE raw.orders AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/olist_orders_dataset.csv'
);

CREATE OR REPLACE TABLE raw.customers AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/olist_customers_dataset.csv'
);

CREATE OR REPLACE TABLE raw.order_items AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/olist_order_items_dataset.csv'
);

CREATE OR REPLACE TABLE raw.order_payments AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/olist_order_payments_dataset.csv'
);

CREATE OR REPLACE TABLE raw.order_reviews AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/olist_order_reviews_dataset.csv'
);

CREATE OR REPLACE TABLE raw.products AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/olist_products_dataset.csv'
);

CREATE OR REPLACE TABLE raw.sellers AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/olist_sellers_dataset.csv'
);

CREATE OR REPLACE TABLE raw.geolocation AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/olist_geolocation_dataset.csv'
);

CREATE OR REPLACE TABLE raw.product_category_translation AS
SELECT *
FROM read_csv_auto(
    'C:/Users/Petya/Documents/Analytics Engineering/ecommerce-analytics-engineering-backup/data/product_category_name_translation.csv'
);