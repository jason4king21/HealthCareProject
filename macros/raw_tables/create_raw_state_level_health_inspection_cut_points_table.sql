
{% macro create_raw_state_level_health_inspection_cut_points_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.STATE_LEVEL_HEALTH_INSPECTION_CUT_POINTS (
            STATE STRING,
        FIVE_STARS STRING,
        FOUR_STARS STRING,
        THREE_STARS STRING,
        TWO_STARS STRING,
        ONE_STAR STRING
        )
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
