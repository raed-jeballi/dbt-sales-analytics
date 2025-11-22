{{
    config(
        materialized='table',
        schema='staging'
    )
}}

SELECT 
    'olist_order_items_dataset' as table_name,
    'primary_key_uniqueness' as validation_type,
    COUNT(*) as total_records,
    COUNT(DISTINCT order_id || '-' || order_item_id) as unique_records,
    COUNT(*) - COUNT(DISTINCT order_id || '-' || order_item_id) as duplicate_count,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT order_id || '-' || order_item_id) THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_order_items_dataset') }}