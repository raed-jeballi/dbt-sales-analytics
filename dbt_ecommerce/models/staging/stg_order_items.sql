{{config(
    materialized = 'table',
    schema = 'staging'
    )
}}

SELECT 
    order_id,
    order_item_id,
    product_id,
    seller_id,
    CASE 
        WHEN PRICE < 0 THEN NULL
        ELSE PRICE 
    END as price,
    CASE 
        WHEN freight_value < 0 THEN NULL
        ELSE freight_value
    END 
    as freight_value
FROM {{source('raw', 'olist_order_items_dataset')}}