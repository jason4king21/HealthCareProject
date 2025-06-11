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
    "Survey Date" AS Survey_Date,
    "Survey Type" AS Survey_Type,
    "Deficiency Prefix" AS Deficiency_Prefix,
    "Deficiency Category" AS Deficiency_Category,
    "Deficiency Tag Number" AS Deficiency_Tag_Number,
    "Deficiency Description" AS Deficiency_Description,
    "Scope Severity Code" AS Scope_Severity_Code,
    "Deficiency Corrected" AS Deficiency_Corrected,
    "Correction Date" AS Correction_Date,
    "Inspection Cycle" AS Inspection_Cycle,
    "Standard Deficiency" AS Standard_Deficiency,
    "Complaint Deficiency" AS Complaint_Deficiency,
    "Infection Control Inspection Deficiency" AS Infection_Control_Inspection_Deficiency,
    "Citation under IDR" AS Citation_under_IDR,
    "Citation under IIDR" AS Citation_under_IIDR,
    "Location" AS Location,
    "Processing Date" AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM {{ source('source', 'HEALTH_DEFICIENCIES') }}