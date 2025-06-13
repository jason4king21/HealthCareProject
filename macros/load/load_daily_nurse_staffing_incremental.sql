{% macro load_daily_nurse_staffing_incremental() %}

    {% set list_files_query %}
        LIST @HEALTHCARE.RAW.MY_STAGE;
    {% endset %}

    {% set file_list_results = run_query(list_files_query) %}

    {% for row in file_list_results %}
        {% set file_url = row[0] %}

        {% if 's3://' in file_url %}
            {% set file_name = file_url.split('raw/healthcare/')[1] %}
        {% else %}
            {% set file_name = file_url %}
        {% endif %}

        {% if file_name.endswith('.csv') and 'Daily_Nurse_Staffing' in file_name %}

            {% set check_query %}
                SELECT COUNT(*)
                FROM HEALTHCARE.RAW.RAW_LOADED_FILES
                WHERE FILE_NAME = '{{ file_name }}'
                  AND TARGET_TABLE = 'HEALTHCARE.RAW.DAILY_NURSE_STAFFING';
            {% endset %}

            {% set check_result = run_query(check_query) %}

            {% if check_result.columns[0].values()[0] == 0 %}

                {% set copy_sql %}
                    COPY INTO HEALTHCARE.RAW.DAILY_NURSE_STAFFING
                    FROM @HEALTHCARE.RAW.MY_STAGE/{{ file_name }}
                    FILE_FORMAT = (
                        TYPE = CSV
                        FIELD_OPTIONALLY_ENCLOSED_BY = '"'
                        PARSE_HEADER = TRUE
                    )
                    MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;
                {% endset %}

                {% do run_query(copy_sql) %}

                {% set insert_sql %}
                    INSERT INTO HEALTHCARE.RAW.RAW_LOADED_FILES
                        (FILE_NAME, LOAD_TIMESTAMP, TARGET_TABLE)
                    VALUES
                        ('{{ file_name }}', CURRENT_TIMESTAMP, 'HEALTHCARE.RAW.DAILY_NURSE_STAFFING');
                {% endset %}

                {% do run_query(insert_sql) %}

            {% endif %}

        {% endif %}

    {% endfor %}

{% endmacro %}
