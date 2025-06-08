
{% macro create_raw_covid19_vax_provider_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.COVID19_VAX_PROVIDER (
    "CMS Certification Number (CCN)" STRING,
    "State" STRING,
    "Percent of residents who are up-to-date on their vaccines" STRING,
    "Percent of staff who are up-to-date on their vaccines" STRING,
    "Date vaccination data last updated" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
