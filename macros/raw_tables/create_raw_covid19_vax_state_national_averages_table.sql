
{% macro create_raw_covid19_vax_state_national_averages_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.COVID19_VAX_STATE_NATIONAL_AVERAGES (
    "State" STRING,
    "Percent of residents who are up-to-date on their vaccines" FLOAT,
    "Percent of staff who are up-to-date on their vaccines" FLOAT,
    "Date vaccination data last updated" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
