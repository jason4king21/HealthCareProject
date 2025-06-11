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
    "Role played by Owner or Manager in Facility" AS Role_played_by_Owner_or_Manager_in_Facility,
    "Owner Type" AS Owner_Type,
    "Owner Name" AS Owner_Name,
    "Ownership Percentage" AS Ownership_Percentage,
    TRY_TO_DATE("Association Date") AS Association_Date,
    "Location" AS Location,
    TRY_TO_DATE("Processing Date") AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM {{ source('source', 'OWNERSHIP') }}
WHERE 1=1
  AND State IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
  AND ZIP_Code IS NOT NULL
  AND ZIP_Code <> ''
  AND TRIM(ZIP_Code) RLIKE '^\\d{5}(-\\d{4})?$'
  AND TRY_TO_NUMBER(REPLACE(Ownership_Percentage, '%', '')) BETWEEN 0 AND 100
  AND Processing_Date IS NOT NULL
  AND Association_Date IS NOT NULL
  AND TRY_TO_DATE(Processing_Date) IS NOT NULL
  AND TRY_TO_DATE(Association_Date) IS NOT NULL
 



