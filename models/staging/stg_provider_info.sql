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
    "Telephone Number" AS Telephone_Number,
    "Provider SSA County Code" AS Provider_SSA_County_Code,
    "County/Parish" AS CountyParish,
    "Ownership Type" AS Ownership_Type,
    "Number of Certified Beds" AS Number_of_Certified_Beds,
    "Average Number of Residents per Day" AS Average_Number_of_Residents_per_Day,
    "Average Number of Residents per Day Footnote" AS Average_Number_of_Residents_per_Day_Footnote,
    "Provider Type" AS Provider_Type,
    "Provider Resides in Hospital" AS Provider_Resides_in_Hospital,
    "Legal Business Name" AS Legal_Business_Name,
    "Date First Approved to Provide Medicare and Medicaid Services" AS Date_First_Approved_to_Provide_Medicare_and_Medicaid_Services,
    "Affiliated Entity Name" AS Affiliated_Entity_Name,
    "Affiliated Entity ID" AS Affiliated_Entity_ID,
    "Continuing Care Retirement Community" AS Continuing_Care_Retirement_Community,
    "Special Focus Status" AS Special_Focus_Status,
    "Abuse Icon" AS Abuse_Icon,
    "Most Recent Health Inspection More Than 2 Years Ago" AS Most_Recent_Health_Inspection_More_Than_2_Years_Ago,
    "Provider Changed Ownership in Last 12 Months" AS Provider_Changed_Ownership_in_Last_12_Months,
    "With a Resident and Family Council" AS With_a_Resident_and_Family_Council,
    "Automatic Sprinkler Systems in All Required Areas" AS Automatic_Sprinkler_Systems_in_All_Required_Areas,
    "Overall Rating" AS Overall_Rating,
    "Overall Rating Footnote" AS Overall_Rating_Footnote,
    "Health Inspection Rating" AS Health_Inspection_Rating,
    "Health Inspection Rating Footnote" AS Health_Inspection_Rating_Footnote,
    "QM Rating" AS QM_Rating,
    "QM Rating Footnote" AS QM_Rating_Footnote,
    "Long-Stay QM Rating" AS LongStay_QM_Rating,
    "Long-Stay QM Rating Footnote" AS LongStay_QM_Rating_Footnote,
    "Short-Stay QM Rating" AS ShortStay_QM_Rating,
    "Short-Stay QM Rating Footnote" AS ShortStay_QM_Rating_Footnote,
    "Staffing Rating" AS Staffing_Rating,
    "Staffing Rating Footnote" AS Staffing_Rating_Footnote,
    "Reported Staffing Footnote" AS Reported_Staffing_Footnote,
    "Physical Therapist Staffing Footnote" AS Physical_Therapist_Staffing_Footnote,
    "Reported Nurse Aide Staffing Hours per Resident per Day" AS Reported_Nurse_Aide_Staffing_Hours_per_Resident_per_Day,
    "Reported LPN Staffing Hours per Resident per Day" AS Reported_LPN_Staffing_Hours_per_Resident_per_Day,
    "Reported RN Staffing Hours per Resident per Day" AS Reported_RN_Staffing_Hours_per_Resident_per_Day,
    "Reported Licensed Staffing Hours per Resident per Day" AS Reported_Licensed_Staffing_Hours_per_Resident_per_Day,
    "Reported Total Nurse Staffing Hours per Resident per Day" AS Reported_Total_Nurse_Staffing_Hours_per_Resident_per_Day,
    "Total number of nurse staff hours per resident per day on the weekend" AS Total_number_of_nurse_staff_hours_per_resident_per_day_on_the_weekend,
    "Registered Nurse hours per resident per day on the weekend" AS Registered_Nurse_hours_per_resident_per_day_on_the_weekend,
    "Reported Physical Therapist Staffing Hours per Resident Per Day" AS Reported_Physical_Therapist_Staffing_Hours_per_Resident_Per_Day,
    "Total nursing staff turnover" AS Total_nursing_staff_turnover,
    "Total nursing staff turnover footnote" AS Total_nursing_staff_turnover_footnote,
    "Registered Nurse turnover" AS Registered_Nurse_turnover,
    "Registered Nurse turnover footnote" AS Registered_Nurse_turnover_footnote,
    "Number of administrators who have left the nursing home" AS Number_of_administrators_who_have_left_the_nursing_home,
    "Administrator turnover footnote" AS Administrator_turnover_footnote,
    "Nursing Case-Mix Index" AS Nursing_CaseMix_Index,
    "Nursing Case-Mix Index Ratio" AS Nursing_CaseMix_Index_Ratio,
    "Case-Mix Nurse Aide Staffing Hours per Resident per Day" AS CaseMix_Nurse_Aide_Staffing_Hours_per_Resident_per_Day,
    "Case-Mix LPN Staffing Hours per Resident per Day" AS CaseMix_LPN_Staffing_Hours_per_Resident_per_Day,
    "Case-Mix RN Staffing Hours per Resident per Day" AS CaseMix_RN_Staffing_Hours_per_Resident_per_Day,
    "Case-Mix Total Nurse Staffing Hours per Resident per Day" AS CaseMix_Total_Nurse_Staffing_Hours_per_Resident_per_Day,
    "Case-Mix Weekend Total Nurse Staffing Hours per Resident per Day" AS CaseMix_Weekend_Total_Nurse_Staffing_Hours_per_Resident_per_Day,
    "Adjusted Nurse Aide Staffing Hours per Resident per Day" AS Adjusted_Nurse_Aide_Staffing_Hours_per_Resident_per_Day,
    "Adjusted LPN Staffing Hours per Resident per Day" AS Adjusted_LPN_Staffing_Hours_per_Resident_per_Day,
    "Adjusted RN Staffing Hours per Resident per Day" AS Adjusted_RN_Staffing_Hours_per_Resident_per_Day,
    "Adjusted Total Nurse Staffing Hours per Resident per Day" AS Adjusted_Total_Nurse_Staffing_Hours_per_Resident_per_Day,
    "Adjusted Weekend Total Nurse Staffing Hours per Resident per Day" AS Adjusted_Weekend_Total_Nurse_Staffing_Hours_per_Resident_per_Day,

    -- DATE columns with proper pattern:
    CASE
        WHEN TRY_TO_DATE("Rating Cycle 1 Standard Survey Health Date") IS NOT NULL
        THEN CAST(TRY_TO_DATE("Rating Cycle 1 Standard Survey Health Date") AS DATE)
        ELSE NULL
    END AS Rating_Cycle_1_Standard_Survey_Health_Date,

    CASE
        WHEN TRY_TO_DATE("Rating Cycle 2 Standard Health Survey Date") IS NOT NULL
        THEN CAST(TRY_TO_DATE("Rating Cycle 2 Standard Health Survey Date") AS DATE)
        ELSE NULL
    END AS Rating_Cycle_2_Standard_Health_Survey_Date,

    CASE
        WHEN TRY_TO_DATE("Rating Cycle 3 Standard Health Survey Date") IS NOT NULL
        THEN CAST(TRY_TO_DATE("Rating Cycle 3 Standard Health Survey Date") AS DATE)
        ELSE NULL
    END AS Rating_Cycle_3_Standard_Health_Survey_Date,

    "Rating Cycle 3 Total Number of Health Deficiencies" AS Rating_Cycle_3_Total_Number_of_Health_Deficiencies,
    "Rating Cycle 3 Number of Standard Health Deficiencies" AS Rating_Cycle_3_Number_of_Standard_Health_Deficiencies,
    "Rating Cycle 3 Number of Complaint Health Deficiencies" AS Rating_Cycle_3_Number_of_Complaint_Health_Deficiencies,
    "Rating Cycle 3 Health Deficiency Score" AS Rating_Cycle_3_Health_Deficiency_Score,
    "Rating Cycle 3 Number of Health Revisits" AS Rating_Cycle_3_Number_of_Health_Revisits,
    "Rating Cycle 3 Health Revisit Score" AS Rating_Cycle_3_Health_Revisit_Score,
    "Rating Cycle 3 Total Health Score" AS Rating_Cycle_3_Total_Health_Score,
    "Total Weighted Health Survey Score" AS Total_Weighted_Health_Survey_Score,
    "Number of Facility Reported Incidents" AS Number_of_Facility_Reported_Incidents,
    "Number of Substantiated Complaints" AS Number_of_Substantiated_Complaints,
    "Number of Citations from Infection Control Inspections" AS Number_of_Citations_from_Infection_Control_Inspections,
    "Number of Fines" AS Number_of_Fines,
    "Total Amount of Fines in Dollars" AS Total_Amount_of_Fines_in_Dollars,
    "Number of Payment Denials" AS Number_of_Payment_Denials,
    "Total Number of Penalties" AS Total_Number_of_Penalties,
    "Location" AS Location,
    "Latitude" AS Latitude,
    "Longitude" AS Longitude,
    "Geocoding Footnote" AS Geocoding_Footnote,

    -- Processing Date with correct pattern:
    CASE
        WHEN TRY_TO_DATE("Processing Date") IS NOT NULL
        THEN CAST(TRY_TO_DATE("Processing Date") AS DATE)
        ELSE NULL
    END AS Processing_Date,

    CURRENT_TIMESTAMP AS ingestion_timestamp

FROM {{ source('source', 'PROVIDER_INFORMATION') }}

WHERE 1=1
  AND State IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
  AND ZIP_Code IS NOT NULL
  AND ZIP_Code <> ''
  AND TRIM(ZIP_Code) RLIKE '^\\d{5}(-\\d{4})?$'
  AND Provider_Resides_in_Hospital IN ('Y','N')
  AND Abuse_Icon IN ('Y','N')
  AND Provider_Changed_Ownership_in_Last_12_Months IN ('Y','N')
  AND Rating_Cycle_1_Standard_Survey_Health_Date IS NOT NULL
  AND Rating_Cycle_2_Standard_Health_Survey_Date IS NOT NULL
  AND Rating_Cycle_3_Standard_Health_Survey_Date IS NOT NULL
  AND Processing_Date IS NOT NULL
