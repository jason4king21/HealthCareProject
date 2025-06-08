
{% macro create_raw_data_collection_intervals_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.DATA_COLLECTION_INTERVALS (
    "Measure Code" STRING,
    "Measure Description" STRING,
    "Data Collection Period From Date" STRING,
    "Data Collection Period Through Date" STRING,
    "Measure Date Range" FLOAT,
    "Processing Date" NUMBER
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
