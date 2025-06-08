
{% macro create_raw_penalties_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.PENALTIES (
    "CMS Certification Number (CCN)" STRING,
    "Provider Name" STRING,
    "Provider Address" STRING,
    "City/Town" STRING,
    "State" STRING,
    "ZIP Code" NUMBER,
    "Penalty Date" STRING,
    "Penalty Type" STRING,
    "Fine Amount" FLOAT,
    "Payment Denial Start Date" STRING,
    "Payment Denial Length in Days" FLOAT,
    "Location" STRING,
    "Processing Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
