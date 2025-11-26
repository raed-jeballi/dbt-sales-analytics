{{
    config(
        materialized='table',   
        schema='validation'  
    )
}}


SELECT * FROM {{ ref('customer_validation') }}
UNION ALL
SELECT * FROM {{ ref('orders_validation') }}
UNION ALL  
SELECT * FROM {{ ref('products_validation') }}
UNION ALL 
SELECT * FROM {{ ref('order_items_validation') }}
UNION ALL
SELECT * FROM {{ ref('sellers_validation') }}
UNION ALL
SELECT * FROM {{ ref('geolocation_validation') }}