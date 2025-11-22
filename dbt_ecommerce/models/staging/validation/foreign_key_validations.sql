{{
    config(
        materialized='table',
        schema='staging'
    )
}}

-- 1. Check if all orders have valid customers
SELECT 
    'orders_to_customers' as relationship_name,
    'foreign_key_integrity' as validation_type,
    COUNT(*) as total_orders,
    COUNT(DISTINCT o.customer_id) as orders_with_customers,
    COUNT(*) - COUNT(DISTINCT o.customer_id) as orphaned_records,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT o.customer_id) THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_orders_dataset') }} o
LEFT JOIN {{ source('raw', 'olist_customers_dataset') }} c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL

-- 2. Check if all order_items have valid orders
SELECT 
    'order_items_to_orders' as relationship_name,
    'foreign_key_integrity' as validation_type,
    COUNT(*) as total_order_items,
    COUNT(DISTINCT oi.order_id) as order_items_with_orders,
    COUNT(*) - COUNT(DISTINCT oi.order_id) as orphaned_records,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT oi.order_id) THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_order_items_dataset') }} oi
LEFT JOIN {{ source('raw', 'olist_orders_dataset') }} o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL

-- 3. Check if all order_items have valid products
SELECT 
    'order_items_to_products' as relationship_name,
    'foreign_key_integrity' as validation_type,
    COUNT(*) as total_order_items,
    COUNT(DISTINCT oi.product_id) as order_items_with_products,
    COUNT(*) - COUNT(DISTINCT oi.product_id) as orphaned_records,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT oi.product_id) THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_order_items_dataset') }} oi
LEFT JOIN {{ source('raw', 'olist_products_dataset') }} p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL