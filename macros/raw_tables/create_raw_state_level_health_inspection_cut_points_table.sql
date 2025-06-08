
{% macro create_raw_state_level_health_inspection_cut_points_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.STATE_LEVEL_HEALTH_INSPECTION_CUT_POINTS (
    "State" STRING,
    "5_Stars" STRING,
    "4_Stars" STRING,
    "3_Stars" STRING,
    "2_Stars" STRING,
    "1_Star" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
