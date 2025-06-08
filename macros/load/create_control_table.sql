
{% macro create_control_table() %}

    CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW_LOADED_FILES (
        FILE_NAME STRING PRIMARY KEY,
        LOAD_TIMESTAMP TIMESTAMP_NTZ,
        TARGET_TABLE STRING
    );

{% endmacro %}
