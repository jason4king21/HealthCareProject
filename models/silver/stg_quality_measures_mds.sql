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
    "Processing Date" AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM { { source('raw', 'MDS_QUALITY_MEASURES') } }