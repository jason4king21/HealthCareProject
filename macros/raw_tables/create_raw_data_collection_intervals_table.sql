
{% macro create_raw_data_collection_intervals_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.DATA_COLLECTION_INTERVALS (
    "Measure_Code" STRING,
    "Measure_Description" STRING,
    "Data_Collection_Period_From_Date" STRING,
    "Data_Collection_Period_Through_Date" STRING,
    "Measure_Date_Range" FLOAT,
    "Processing_Date" NUMBER
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
