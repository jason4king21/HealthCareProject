
{% macro load_covid19_vax_state_national_averages_incremental() %}

    {% set list_files_query %}
        LIST @HEALTHCARE.RAW.MY_STAGE;
    {% endset %}

    {% set file_list_results = run_query(list_files_query) %}

    {% for row in file_list_results %}
        {% set file_name = row[1] %}

        {% if file_name.endswith('.csv') and 'NH_CovidVaxAverages_' in file_name %}

            {% set check_query %}
                SELECT COUNT(*) FROM HEALTHCARE.RAW.RAW_LOADED_FILES WHERE FILE_NAME = '{{ file_name }}';
            {% endset %}

            {% set check_result = run_query(check_query) %}

            {% if check_result.columns[0].values()[0] == 0 %}

                {% set copy_sql %}
                    COPY INTO HEALTHCARE.RAW.COVID19_VAX_STATE_NATIONAL_AVERAGES
                    FROM @HEALTHCARE.RAW.MY_STAGE/{{ file_name }}
                    FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"' PARSE_HEADER = TRUE)
                    MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;
                {% endset %}

                {% do run_query(copy_sql) %}

                {% set insert_sql %}
                    INSERT INTO HEALTHCARE.RAW.RAW_LOADED_FILES (FILE_NAME, LOAD_TIMESTAMP, TARGET_TABLE)
                    VALUES ('{{ file_name }}', CURRENT_TIMESTAMP, 'HEALTHCARE.RAW.COVID19_VAX_STATE_NATIONAL_AVERAGES');
                {% endset %}

                {% do run_query(insert_sql) %}

            {% endif %}

        {% endif %}

    {% endfor %}

{% endmacro %}
