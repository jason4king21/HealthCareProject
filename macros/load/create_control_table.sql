{% macro create_control_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.RAW_LOADED_FILES (
            FILE_NAME STRING PRIMARY KEY,
            LOAD_TIMESTAMP TIMESTAMP_NTZ,
            TARGET_TABLE STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}

