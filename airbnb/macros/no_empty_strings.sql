{#
Safe `no_empty_strings` macro.

Usage:
  - `no_empty_strings(model)` (original behavior) — inspects the model columns at compile-time.
  - `no_empty_strings(model, columns=['col1','col2'])` — safer for environments
    (like Fusion) that may not implement adapter introspection. Passing `columns`
    avoids calling `adapter.get_columns_in_relation`.
#}

{% macro no_empty_strings(model, columns=None) %}
    {%- if columns is not none -%}
        {%- for col_name in columns -%}
            {{ col_name }} IS NOT NULL AND {{ col_name }} <> '' AND
        {%- endfor -%}
    {%- else -%}
        {%- for col in adapter.get_columns_in_relation(model) -%}
            {%- if col.is_string() %}
                {{ col.name }} IS NOT NULL AND {{ col.name }} <> '' AND
            {%- endif %}
        {%- endfor -%}
    {%- endif -%}
    TRUE
{% endmacro %}