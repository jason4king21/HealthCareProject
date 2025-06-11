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
    "Q1 Measure Score" AS Q1_Measure_Score,
    "Footnote for Q1 Measure Score" AS Footnote_for_Q1_Measure_Score,
    "Q2 Measure Score" AS Q2_Measure_Score,
    "Footnote for Q2 Measure Score" AS Footnote_for_Q2_Measure_Score,
    "Q3 Measure Score" AS Q3_Measure_Score,
    "Footnote for Q3 Measure Score" AS Footnote_for_Q3_Measure_Score,
    "Q4 Measure Score" AS Q4_Measure_Score,
    "Footnote for Q4 Measure Score" AS Footnote_for_Q4_Measure_Score,
    "Four Quarter Average Score" AS Four_Quarter_Average_Score,
    "Footnote for Four Quarter Average Score" AS Footnote_for_Four_Quarter_Average_Score,
    "Used in Quality Measure Five Star Rating" AS Used_in_Quality_Measure_Five_Star_Rating,
    "Measure Period" AS Measure_Period,
    "Location" AS Location,
    TRY_TO_DATE("Processing Date") AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM {{ source('source', 'MDS_QUALITY_MEASURES') }}
WHERE 1=1
  AND State IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
  AND ZIP_Code IS NOT NULL
  AND ZIP_Code <> ''
  AND TRIM(ZIP_Code) RLIKE '^\\d{5}(-\\d{4})?$'
  AND Used_in_Quality_Measure_Five_Star_Rating IN ('Y','N')
  AND Four_Quarter_Average_Score BETWEEN 0 AND 100
  AND Processing_Date IS NOT NULL
  AND TRY_TO_DATE(Processing_Date) IS NOT NULL



