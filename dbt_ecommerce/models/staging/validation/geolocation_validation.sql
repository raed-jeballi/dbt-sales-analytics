{{
    config(
        materialized='table',
        schema='staging'
    )
}}

SELECT 
    'olist_geolocation_dataset' as table_name,
    'primary_key_uniqueness' as validation_type,
    COUNT(*) as total_records,
    COUNT(DISTINCT geolocation_zip_code_prefix || '-' || geolocation_lat || '-' || geolocation_lng) as unique_records,
    COUNT(*) - unique_records as duplicate_count,
    CASE 
        WHEN COUNT(*) = unique_records THEN 'PASS'
        ELSE 'FAIL'
    END as validation_status,
    CURRENT_TIMESTAMP() as validated_at
FROM {{ source('raw', 'olist_geolocation_dataset') }}