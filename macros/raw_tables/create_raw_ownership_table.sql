
{% macro create_raw_ownership_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.OWNERSHIP (
    "CMS Certification Number (CCN)" STRING,
    "Provider Name" STRING,
    "Provider Address" STRING,
    "City/Town" STRING,
    "State" STRING,
    "ZIP Code" NUMBER,
    "Role played by Owner or Manager in Facility" STRING,
    "Owner Type" STRING,
    "Owner Name" STRING,
    "Ownership Percentage" STRING,
    "Association Date" STRING,
    "Location" STRING,
    "Processing Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
