{{ codegen.generate_base_model(
    source_name='github',
    table_name='issue',
    materialized='table'
) }}

{{ codegen.generate_base_model(
    source_name='github',
    table_name='pull_request',
    materialized='table'
) }}

{{ codegen.generate_base_model(
    source_name='github',
    table_name='repository',
    materialized='table'
) }}