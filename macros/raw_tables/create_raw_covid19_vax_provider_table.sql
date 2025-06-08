
{% macro create_raw_covid19_vax_provider_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.COVID19_VAX_PROVIDER (
    "CMS_Certification_Number_(CCN)" STRING,
    "State" STRING,
    "Percent_of_residents_who_are_up_to_date_on_their_vaccines" STRING,
    "Percent_of_staff_who_are_up_to_date_on_their_vaccines" STRING,
    "Date_vaccination_data_last_updated" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
