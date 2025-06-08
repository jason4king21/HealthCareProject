
{% macro create_raw_ownership_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.OWNERSHIP (
    "CMS_Certification_Number_(CCN)" NUMBER,
    "Provider_Name" STRING,
    "Provider_Address" STRING,
    "City_Town" STRING,
    "State" STRING,
    "ZIP_Code" NUMBER,
    "Role_played_by_Owner_or_Manager_in_Facility" STRING,
    "Owner_Type" STRING,
    "Owner_Name" STRING,
    "Ownership_Percentage" STRING,
    "Association_Date" STRING,
    "Location" STRING,
    "Processing_Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
