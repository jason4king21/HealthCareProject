
{% macro profile_raw_table(table_name) %}

    {% set columns_query %}
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = UPPER('{{ table_name }}')
          AND TABLE_SCHEMA = 'RAW'
          AND TABLE_CATALOG = 'HEALTHCARE'
        ORDER BY ORDINAL_POSITION;
    {% endset %}

    {% set columns_result = run_query(columns_query) %}
    {% set column_names = columns_result.columns[0].values() %}

    {% set profiling_sql %}
        WITH base AS (
            SELECT
                COUNT(*) AS row_count
            FROM HEALTHCARE.RAW.{{ table_name }}
        ),
        null_counts AS (
            SELECT
                {% for col in column_names %}
                SUM(CASE WHEN "{{ col }}" IS NULL THEN 1 ELSE 0 END) AS "{{ col }}_null_count"{% if not loop.last %},{% endif %}
                {% endfor %}
            FROM HEALTHCARE.RAW.{{ table_name }}
        ),
        duplicates AS (
            {% for col in column_names %}
            SELECT
                '{{ col }}' AS column_name,
                COUNT(*) AS duplicate_count
            FROM (
                SELECT "{{ col }}", COUNT(*) AS cnt
                FROM HEALTHCARE.RAW.{{ table_name }}
                GROUP BY "{{ col }}"
                HAVING COUNT(*) > 1
            ) dup
            {% if not loop.last %}UNION ALL{% endif %}
            {% endfor %}
        )
        SELECT
            '{{ table_name }}' AS table_name,
            base.row_count,
            null_counts.*
        FROM base, null_counts;

    {% endset %}

    {% do log('Running profiling query for table: ' ~ table_name, info=True) %}
    {% do run_query(profiling_sql) %}

{% endmacro %}
