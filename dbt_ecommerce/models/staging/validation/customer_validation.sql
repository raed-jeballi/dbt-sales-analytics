{{
    config(
        materialized='table',
        schema='staging'
    )
}}

-- Simple check: Are customer IDs unique?
SELECT 
    'olist_customers_dataset' as table_name,
    'primary_key_uniqueness' as validation_type,
    COUNT(*) as total_records,
    COUNT(DISTINCT customer_id) as unique_records,
    COUNT(*) - COUNT(DISTINCT customer_id) as duplicate_count,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT customer_id) THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_customers_dataset') }}