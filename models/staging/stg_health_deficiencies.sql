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
    CASE
        WHEN REGEXP_REPLACE(TRIM("ZIP Code"), '[^0-9\\-]', '') RLIKE '^\\d{5}(-\\d{4})?$'
        THEN CAST(REGEXP_REPLACE(TRIM("ZIP Code"), '[^0-9\\-]', '') AS STRING)
        ELSE NULL
    END AS ZIP_Code,
    TRY_TO_DATE("Survey Date") AS Survey_Date,
    "Survey Type" AS Survey_Type,
    "Deficiency Prefix" AS Deficiency_Prefix,
    "Deficiency Category" AS Deficiency_Category,
    "Deficiency Tag Number" AS Deficiency_Tag_Number,
    "Deficiency Description" AS Deficiency_Description,
    "Scope Severity Code" AS Scope_Severity_Code,
    "Deficiency Corrected" AS Deficiency_Corrected,
    TRY_TO_DATE("Correction Date") AS Correction_Date,
    "Inspection Cycle" AS Inspection_Cycle,
    "Standard Deficiency" AS Standard_Deficiency,
    "Complaint Deficiency" AS Complaint_Deficiency,
    "Infection Control Inspection Deficiency" AS Infection_Control_Inspection_Deficiency,
    "Citation under IDR" AS Citation_under_IDR,
    "Citation under IIDR" AS Citation_under_IIDR,
    "Location" AS Location,
    TRY_TO_DATE("Processing Date") AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM {{ source('source', 'HEALTH_DEFICIENCIES') }}
WHERE 1=1
  AND State IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
  AND ZIP_Code IS NOT NULL
  AND ZIP_Code <> ''
  AND Standard_Deficiency IN ('Y','N')
  AND Complaint_Deficiency IN ('Y','N')
  AND Infection_Control_Inspection_Deficiency IN ('Y','N')
  AND Citation_under_IDR IN ('Y','N')
  AND Citation_under_IIDR IN ('Y','N')
  AND Processing_Date IS NOT NULL
  AND Survey_Date IS NOT NULL
  AND Correction_Date IS NOT NULL
  AND TRY_TO_DATE(Processing_Date) IS NOT NULL
  AND TRY_TO_DATE(Survey_Date) IS NOT NULL
  AND TRY_TO_DATE(Correction_Date) IS NOT NULL





