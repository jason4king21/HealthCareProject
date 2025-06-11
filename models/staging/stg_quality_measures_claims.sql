{{ config(
    materialized='table',
    tags=['silver', 'profiled']
) }}

SELECT
    "CMS Certification Number (CCN)" AS CMS_Certification_Number_CCN,
    "Provider Name" AS Provider_Name,
    "Provider Address" AS Provider_Address,
    "City/Town" AS CityTown,
    "State" AS State,
    "ZIP Code" AS ZIP_Code,
    "Measure Code" AS Measure_Code,
    "Measure Description" AS Measure_Description,
    "Resident type" AS Resident_type,
    "Adjusted Score" AS Adjusted_Score,
    "Observed Score" AS Observed_Score,
    "Expected Score" AS Expected_Score,
    "Footnote for Score" AS Footnote_for_Score,
    "Used in Quality Measure Five Star Rating" AS Used_in_Quality_Measure_Five_Star_Rating,
    "Measure Period" AS Measure_Period,
    "Location" AS Location,
    "Processing Date" AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM {{ source('source', 'MEDICARE_CLAIMS_QUALITY_MEASURES') }}