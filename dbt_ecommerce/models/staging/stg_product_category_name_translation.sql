{{
    config(
        materialized='table',
        schema='staging'
    )
}}

SELECT
    product_category_name,
    product_category_name_english
FROM {{ source('raw', 'product_category_name_translation') }}