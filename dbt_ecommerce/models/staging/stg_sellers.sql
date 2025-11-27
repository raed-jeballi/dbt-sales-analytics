{{
    config(
        materialized='table',
        schema='staging'
    )
}}

SELECT
    seller_id,
    -- Standardize seller city names (same pattern as customers)
    CASE 
        WHEN LOWER(seller_city) LIKE 's%ulo' THEN 'Sao Paulo'
        ELSE seller_city
    END as seller_city,
    seller_state,
    seller_zip_code_prefix
FROM {{ source('raw', 'olist_sellers_dataset') }}