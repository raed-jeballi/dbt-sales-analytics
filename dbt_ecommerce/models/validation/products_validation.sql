{{
    config(
        materialized='table',   
        schema='validation'  
    )
}}


SELECT 
    'olist_products_dataset' as table_name,
    'primary_key_uniqueness' as validation_type,
    COUNT(*) as total_records,
    COUNT(DISTINCT product_id) as unique_records,
    COUNT(*) - COUNT(DISTINCT product_id) as duplicate_count,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT product_id) THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_products_dataset') }}