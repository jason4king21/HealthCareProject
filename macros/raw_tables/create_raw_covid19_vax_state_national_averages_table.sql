
{% macro create_raw_covid19_vax_state_national_averages_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.COVID19_VAX_STATE_NATIONAL_AVERAGES (
    "State" STRING,
    "Percent_of_residents_who_are_up_to_date_on_their_vaccines" FLOAT,
    "Percent_of_staff_who_are_up_to_date_on_their_vaccines" FLOAT,
    "Date_vaccination_data_last_updated" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
