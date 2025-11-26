{{
    config(
        materialized='table',   
        schema='validation'  
    )
}}


-- Simple check: Are order IDs unique?
SELECT 
    'olist_orders_dataset' as table_name,
    'primary_key_uniqueness' as validation_type,
    COUNT(*) as total_records,
    COUNT(DISTINCT order_id) as unique_records,
    COUNT(*) - COUNT(DISTINCT order_id) as duplicate_count,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT order_id) THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_orders_dataset') }}