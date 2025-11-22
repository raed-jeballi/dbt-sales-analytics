{{
    config(
        materialized='table',   
        schema='validation'  
    )
}}


SELECT 
    'olist_sellers_dataset' as table_name,
    'primary_key_uniqueness' as validation_type,
    COUNT(*) as total_records,
    COUNT(DISTINCT seller_id) as unique_records,
    COUNT(*) - COUNT(DISTINCT seller_id) as duplicate_count,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT seller_id) THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_sellers_dataset') }}