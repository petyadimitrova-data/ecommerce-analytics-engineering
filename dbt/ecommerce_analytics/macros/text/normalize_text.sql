{%- macro normalize_text(text_expression) -%}

{#
    normalize_text()

    Purpose:
        Standardize textual values used throughout the warehouse.

    Current transformations:
        • trim whitespace
        • convert to lowercase
        • remove Portuguese accents

    Version:
        1.0
#}

{%- set ns = namespace(expression="lower(trim(" ~ text_expression ~ "))") -%}

{%- set replacements = {
    'á':'a',
    'à':'a',
    'â':'a',
    'ã':'a',
    'ä':'a',
    'é':'e',
    'è':'e',
    'ê':'e',
    'ë':'e',
    'í':'i',
    'ì':'i',
    'î':'i',
    'ï':'i',
    'ó':'o',
    'ò':'o',
    'ô':'o',
    'õ':'o',
    'ö':'o',
    'ú':'u',
    'ù':'u',
    'û':'u',
    'ü':'u',
    'ç':'c'
} -%}

{%- for old, new in replacements.items() -%}
    {%- set ns.expression =
        "replace(" ~
        ns.expression ~
        ", '" ~ old ~ "', '" ~ new ~ "')"
    -%}
{%- endfor -%}

{{ ns.expression }}

{%- endmacro -%}