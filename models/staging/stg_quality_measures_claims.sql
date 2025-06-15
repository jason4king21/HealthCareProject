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
    NULLIF(REGEXP_REPLACE(TRIM("ZIP Code"), '[^0-9\\-]', ''), '') AS ZIP_Code,
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
    TRY_TO_DATE("Processing Date") AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM {{ source('RAW', 'MEDICARE_CLAIMS_QUALITY_MEASURES') }}
WHERE 1=1
  AND State IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
  AND ZIP_Code IS NOT NULL
  AND ZIP_Code <> ''
  AND TRIM(ZIP_Code) RLIKE '^\\d{5}(-\\d{4})?$'
  AND Used_in_Quality_Measure_Five_Star_Rating IN ('Y','N')
  AND Adjusted_Score BETWEEN 0 AND 100
  AND Processing_Date IS NOT NULL
  AND TRY_TO_DATE(Processing_Date) IS NOT NULL



