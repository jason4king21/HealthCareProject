
{% macro create_raw_data_collection_intervals_table() %}

    {% set table_exists_query %}
        SELECT COUNT(*) 
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_SCHEMA = 'RAW' 
          AND TABLE_NAME = 'DATA_COLLECTION_INTERVALS'
    {% endset %}

    {% set results = run_query(table_exists_query) %}
    {% if results.columns[0].values()[0] == 0 %}

        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.DATA_COLLECTION_INTERVALS (
            MEASURE_CODE STRING,
        MEASURE_DESCRIPTION STRING,
        DATA_COLLECTION_PERIOD_FROM_DATE DATE,
        DATA_COLLECTION_PERIOD_THROUGH_DATE DATE,
        MEASURE_DATE_RANGE STRING,
        PROCESSING_DATE DATE
        );

    {% else %}
        -- Table DATA_COLLECTION_INTERVALS already exists. Skipping.
    {% endif %}

{% endmacro %}
