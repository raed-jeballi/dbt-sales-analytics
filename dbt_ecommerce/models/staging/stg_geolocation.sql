{{
    config(
        materialized='table',
        schema='staging'
    )
}}

SELECT
    geolocation_zip_code_prefix,
    -- Standardize city names (consistent with customers/sellers)
    CASE 
        WHEN LOWER(geolocation_city) LIKE 's%ulo' THEN 'Sao Paulo'
        ELSE geolocation_city
    END as geolocation_city,
    geolocation_state,
    geolocation_lat,
    geolocation_lng
FROM {{ source('raw', 'olist_geolocation_dataset') }}