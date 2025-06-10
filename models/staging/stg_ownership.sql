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
    "Role played by Owner or Manager in Facility" AS Role_played_by_Owner_or_Manager_in_Facility,
    "Owner Type" AS Owner_Type,
    "Owner Name" AS Owner_Name,
    "Ownership Percentage" AS Ownership_Percentage,
    "Association Date" AS Association_Date,
    "Location" AS Location,
    "Processing Date" AS Processing_Date,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM { source('raw', 'OWNERSHIP') }