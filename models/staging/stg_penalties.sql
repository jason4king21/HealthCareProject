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
    TRY_TO_DATE("Penalty Date") AS Penalty_Date,
    "Penalty Type" AS Penalty_Type,
    "Fine Amount" AS Fine_Amount,
    TRY_TO_DATE("Payment Denial Start Date") AS Payment_Denial_Start_Date,
    "Payment Denial Length in Days" AS Payment_Denial_Length_in_Days,
    "Location" AS Location,
    TRY_TO_DATE("Processing Date") AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM {{ source('RAW', 'PENALTIES') }}
WHERE 1=1
  AND State IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
  AND ZIP_Code IS NOT NULL
  AND ZIP_Code <> ''
  AND TRIM(ZIP_Code) RLIKE '^\\d{5}(-\\d{4})?$'
  AND Fine_Amount >= 0
  AND Processing_Date IS NOT NULL
  AND Penalty_Date IS NOT NULL
  AND TRY_TO_DATE(Penalty_Date) IS NOT NULL
  AND Payment_Denial_Start_Date IS NOT NULL
  AND TRY_TO_DATE(Payment_Denial_Start_Date) IS NOT NULL
  AND TRY_TO_DATE(Penalty_Date) IS NOT NULL




