{ config(
    materialized='table',
    tags=['silver', 'profiled']
) }

SELECT
    -- Example mapping, replace with full column list
    *,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM { source('raw', 'MEDICARE_CLAIMS_QUALITY_MEASURES') }
