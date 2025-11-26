{{
    config(
        materialized='table',
        schema='staging'
    )
}}

SELECT
    customer_id,
    customer_unique_id,
    -- Standardize city names (fix Sao Paulo spellings)
    CASE 
        WHEN LOWER(customer_city) LIKE 's%ulo' THEN 'Sao Paulo'
        ELSE customer_city
    END as customer_city,
    customer_state,
    customer_zip_code_prefix
FROM {{ source('raw', 'olist_customers_dataset') }}