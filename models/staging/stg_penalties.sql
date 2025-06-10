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
    "Penalty Date" AS Penalty_Date,
    "Penalty Type" AS Penalty_Type,
    "Fine Amount" AS Fine_Amount,
    "Payment Denial Start Date" AS Payment_Denial_Start_Date,
    "Payment Denial Length in Days" AS Payment_Denial_Length_in_Days,
    "Location" AS Location,
    "Processing Date" AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM { { source('raw', 'PENALTIES') } }