{#
drop_dev_schemas

Original behaviour: inspects information_schema for any schemas starting with
the resolved `target.schema` prefix (e.g. DBT_<ENV>) and drops them via
`run_query` calls. Some execution environments (Fusion) may not implement
`run_query` or runtime adapter introspection.

Safer usage:
  - `drop_dev_schemas(schemas=['DBT_DEV1','DBT_DEV2'])` — provide the exact
    schema names to drop (recommended for Fusion).
  - `drop_dev_schemas()` — preserves the original behaviour as a fallback.
#}

{% macro drop_dev_schemas(schemas=None) %}

  {# Use the resolved target schema as the prefix (e.g. DBT_<env_name> on dev) #}
  {% set prefix = target.schema | upper %}

  {# Safety guard: only drop dev schemas (prefixed DBT_), never PROD/STAGING #}
  {% if not prefix.startswith('DBT_') %}
    {{ exceptions.raise_compiler_error("Refusing to drop schemas: target.schema (" ~ prefix ~ ") is not a dev schema (must start with DBT_)") }}
  {% endif %}

  {{ log(" * drop_dev_schemas: Looking for schemas with prefix:  " ~ prefix, info=True) }}

  {# If caller provided an explicit list, use it (safer). Otherwise fall back #}
  {% if schemas is not none %}
    {% set to_drop = schemas %}
  {% else %}
    {# Find all schemas matching the prefix (fallback; uses run_query) #}
    {% set results = run_query(
      "SELECT schema_name
       FROM information_schema.schemata
       WHERE schema_name ILIKE '" ~ prefix ~ "%'"
    ) %}
    {% set to_drop = results.columns[0].values() %}
  {% endif %}

  {# Drop each matching schema #}
  {% if execute %}
    {% if to_drop | length == 0 %}
      {{ log(" * drop_dev_schemas: No schemas found matching prefix: " ~ prefix, info=True) }}
    {% else %}
      {{ log(" * drop_dev_schemas: Found " ~ to_drop | length ~ " schema(s) to drop:", info=True) }}
      {% for schema in to_drop %}
        {{ log(" * drop_dev_schemas: Dropping: " ~ schema, info=True) }}
        {% do run_query("DROP SCHEMA IF EXISTS " ~ schema ~ " CASCADE") %}
      {% endfor %}
    {% endif %}
  {% endif %}

{% endmacro %}
