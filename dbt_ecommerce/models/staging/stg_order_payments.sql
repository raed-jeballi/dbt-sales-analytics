{{
    config(
        materialized='table',
        schema='staging'
    )
}}

SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    -- Validate payment values (similar to order items)
    CASE 
        WHEN payment_value < 0 THEN NULL
        ELSE payment_value
    END as payment_value
FROM {{ source('raw', 'olist_order_payments_dataset') }}