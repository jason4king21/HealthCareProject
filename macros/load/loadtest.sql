{% macro loadtest() %}

    {% set list_files_query %}
        LIST @HEALTHCARE.RAW.MY_STAGE;
    {% endset %}

    {% do log('STEP 1 - Running LIST query:', info=True) %}
    {% do log(list_files_query, info=True) %}

    {% set file_list_results = run_query(list_files_query) %}

    {% do log('STEP 2 - Files found:', info=True) %}
    {% for row in file_list_results %}
        {% set file_name = row[0] %}
        {% do log('Checking file: ' ~ file_name, info=True) %}

        {% if file_name.endswith('.csv') and 'NH_CovidVaxProvider_' in file_name %}
            {% do log('MATCHED file for loading: ' ~ file_name, info=True) %}

            {% set check_query %}
                SELECT COUNT(*) FROM HEALTHCARE.RAW.RAW_LOADED_FILES WHERE FILE_NAME = '{{ file_name }}';
            {% endset %}

            {% do log('STEP 3 - Running CHECK query:', info=True) %}
            {% do log(check_query, info=True) %}

            {% set check_result = run_query(check_query) %}

            {% set file_already_loaded = check_result.columns[0].values()[0] %}
            {% do log('STEP 4 - File already loaded count: ' ~ file_already_loaded, info=True) %}

            {% if file_already_loaded == 0 %}
                {% do log('STEP 5 - Starting COPY INTO for file: ' ~ file_name, info=True) %}

                {% set copy_sql %}
                    COPY INTO HEALTHCARE.RAW.COVID19_VAX_PROVIDER
                    FROM @HEALTHCARE.RAW.MY_STAGE/{{ file_name }}
                    FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"' PARSE_HEADER = TRUE)
                    MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;
                {% endset %}

                {% do log('COPY SQL:', info=True) %}
                {% do log(copy_sql, info=True) %}

                {% do run_query(copy_sql) %}

                {% do log('STEP 6 - Inserting record into RAW_LOADED_FILES', info=True) %}

                {% set insert_sql %}
                    INSERT INTO HEALTHCARE.RAW.RAW_LOADED_FILES (FILE_NAME, LOAD_TIMESTAMP, TARGET_TABLE)
                    VALUES ('{{ file_name }}', CURRENT_TIMESTAMP, 'HEALTHCARE.RAW.COVID19_VAX_PROVIDER');
                {% endset %}

                {% do log('INSERT SQL:', info=True) %}
                {% do log(insert_sql, info=True) %}

                {% do run_query(insert_sql) %}

                {% do log('STEP 7 - Finished processing file: ' ~ file_name, info=True) %}

            {% else %}
                {% do log('File already loaded previously: ' ~ file_name, info=True) %}
            {% endif %}

        {% else %}
            {% do log('Skipping file (no match): ' ~ file_name, info=True) %}
        {% endif %}

    {% endfor %}

    {% do log('STEP 8 - Completed load_covid19_vax_provider_incremental()', info=True) %}

{% endmacro %}
