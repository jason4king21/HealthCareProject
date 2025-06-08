
{% macro create_raw_state_level_health_inspection_cut_points_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.STATE_LEVEL_HEALTH_INSPECTION_CUT_POINTS (
    "State" STRING,
    "5 Stars" STRING,
    "4 Stars" STRING,
    "3 Stars" STRING,
    "2 Stars" STRING,
    "1 Star" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
