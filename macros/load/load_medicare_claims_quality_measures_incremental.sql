
{% macro load_medicare_claims_quality_measures_incremental() %}

    {% set list_files_query %}
        LIST @my_stage/NH_QualityMsr_Claims_*.csv;
    {% endset %}

    {% set file_list_results = run_query(list_files_query) %}

    {% for row in file_list_results %}
        {% set file_name = row[0] %}

        {% set check_query %}
            SELECT COUNT(*) FROM HEALTHCARE.RAW_LOADED_FILES WHERE FILE_NAME = '{{ file_name }}';
        {% endset %}

        {% set check_result = run_query(check_query) %}

        {% if check_result.columns[0].values()[0] == 0 %}

            {% set copy_sql %}
                COPY INTO HEALTHCARE.RAW.MEDICARE_CLAIMS_QUALITY_MEASURES
                FROM @my_stage/{{ file_name }}
                FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER=1);
            {% endset %}

            {% do run_query(copy_sql) %}

            {% set insert_sql %}
                INSERT INTO HEALTHCARE.RAW_LOADED_FILES (FILE_NAME, LOAD_TIMESTAMP, TARGET_TABLE)
                VALUES ('{{ file_name }}', CURRENT_TIMESTAMP, 'HEALTHCARE.RAW.MEDICARE_CLAIMS_QUALITY_MEASURES');
            {% endset %}

            {% do run_query(insert_sql) %}

        {% endif %}

    {% endfor %}

{% endmacro %}
