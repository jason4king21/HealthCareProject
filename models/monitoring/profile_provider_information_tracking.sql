{{ config(
    materialized='incremental',
    unique_key="table_name || '_' || run_date",
    incremental_strategy='insert_overwrite'
) }}

{% set column_names = [
    'CMS Certification Number (CCN)',
    'Provider Name',
    'Provider Address',
    'City/Town',
    'State',
    'ZIP Code',
    'Telephone Number',
    'Provider SSA County Code',
    'County/Parish',
    'Ownership Type',
    'Number of Certified Beds',
    'Average Number of Residents per Day',
    'Average Number of Residents per Day Footnote',
    'Provider Type',
    'Provider Resides in Hospital',
    'Legal Business Name',
    'Date First Approved to Provide Medicare and Medicaid Services',
    'Affiliated Entity Name',
    'Affiliated Entity ID',
    'Continuing Care Retirement Community',
    'Special Focus Status',
    'Abuse Icon',
    'Most Recent Health Inspection More Than 2 Years Ago',
    'Provider Changed Ownership in Last 12 Months',
    'With a Resident and Family Council',
    'Automatic Sprinkler Systems in All Required Areas',
    'Overall Rating',
    'Overall Rating Footnote',
    'Health Inspection Rating',
    'Health Inspection Rating Footnote',
    'QM Rating',
    'QM Rating Footnote',
    'Long-Stay QM Rating',
    'Long-Stay QM Rating Footnote',
    'Short-Stay QM Rating',
    'Short-Stay QM Rating Footnote',
    'Staffing Rating',
    'Staffing Rating Footnote',
    'Reported Staffing Footnote',
    'Physical Therapist Staffing Footnote',
    'Reported Nurse Aide Staffing Hours per Resident per Day',
    'Reported LPN Staffing Hours per Resident per Day',
    'Reported RN Staffing Hours per Resident per Day',
    'Reported Licensed Staffing Hours per Resident per Day',
    'Reported Total Nurse Staffing Hours per Resident per Day',
    'Total number of nurse staff hours per resident per day on the weekend',
    'Registered Nurse hours per resident per day on the weekend',
    'Reported Physical Therapist Staffing Hours per Resident Per Day',
    'Total nursing staff turnover',
    'Total nursing staff turnover footnote',
    'Registered Nurse turnover',
    'Registered Nurse turnover footnote',
    'Number of administrators who have left the nursing home',
    'Administrator turnover footnote',
    'Nursing Case-Mix Index',
    'Nursing Case-Mix Index Ratio',
    'Case-Mix Nurse Aide Staffing Hours per Resident per Day',
    'Case-Mix LPN Staffing Hours per Resident per Day',
    'Case-Mix RN Staffing Hours per Resident per Day',
    'Case-Mix Total Nurse Staffing Hours per Resident per Day',
    'Case-Mix Weekend Total Nurse Staffing Hours per Resident per Day',
    'Adjusted Nurse Aide Staffing Hours per Resident per Day',
    'Adjusted LPN Staffing Hours per Resident per Day',
    'Adjusted RN Staffing Hours per Resident per Day',
    'Adjusted Total Nurse Staffing Hours per Resident per Day',
    'Adjusted Weekend Total Nurse Staffing Hours per Resident per Day',
    'Rating Cycle 1 Standard Survey Health Date',
    'Rating Cycle 1 Total Number of Health Deficiencies',
    'Rating Cycle 1 Number of Standard Health Deficiencies',
    'Rating Cycle 1 Number of Complaint Health Deficiencies',
    'Rating Cycle 1 Health Deficiency Score',
    'Rating Cycle 1 Number of Health Revisits',
    'Rating Cycle 1 Health Revisit Score',
    'Rating Cycle 1 Total Health Score',
    'Rating Cycle 2 Standard Health Survey Date',
    'Rating Cycle 2 Total Number of Health Deficiencies',
    'Rating Cycle 2 Number of Standard Health Deficiencies',
    'Rating Cycle 2 Number of Complaint Health Deficiencies',
    'Rating Cycle 2 Health Deficiency Score',
    'Rating Cycle 2 Number of Health Revisits',
    'Rating Cycle 2 Health Revisit Score',
    'Rating Cycle 2 Total Health Score',
    'Rating Cycle 3 Standard Health Survey Date',
    'Rating Cycle 3 Total Number of Health Deficiencies',
    'Rating Cycle 3 Number of Standard Health Deficiencies',
    'Rating Cycle 3 Number of Complaint Health Deficiencies',
    'Rating Cycle 3 Health Deficiency Score',
    'Rating Cycle 3 Number of Health Revisits',
    'Rating Cycle 3 Health Revisit Score',
    'Rating Cycle 3 Total Health Score',
    'Total Weighted Health Survey Score',
    'Number of Facility Reported Incidents',
    'Number of Substantiated Complaints',
    'Number of Citations from Infection Control Inspections',
    'Number of Fines',
    'Total Amount of Fines in Dollars',
    'Number of Payment Denials',
    'Total Number of Penalties',
    'Location',
    'Latitude',
    'Longitude',
    'Geocoding Footnote',
    'Processing Date'
] %}

WITH base_info AS (
    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.PROVIDER_INFORMATION
), null_counts AS (
    SELECT
        {% for col in column_names %}
            {% set cleaned_col_name = col 
                | replace(" ", "_")
                | replace("(", "")
                | replace(")", "")
                | replace("/", "_")
                | replace("-", "_")
                | lower %}
        SUM(CASE WHEN "{{ col }}" IS NULL THEN 1 ELSE 0 END) AS "{{ cleaned_col_name }}_null_count"{% if not loop.last %},{% endif %}
        {% endfor %}
    FROM HEALTHCARE.RAW.PROVIDER_INFORMATION
)

SELECT
    'PROVIDER_INFORMATION' AS table_name,
    CURRENT_TIMESTAMP() AS run_date,
    base_info.row_count,
    {% for col in column_names %}
        {% set cleaned_col_name = col 
            | replace(" ", "_")
            | replace("(", "")
            | replace(")", "")
            | replace("/", "_")
            | replace("-", "_")
            | lower %}
    null_counts."{{ cleaned_col_name }}_null_count" AS "{{ cleaned_col_name }}_null_count"{% if not loop.last %},{% endif %}
    {% endfor %}
FROM base_info, null_counts