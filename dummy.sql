{{
  config(
    materialized="table",
    schema=set_schema_based_on_folder()
  )
}}

{% do copy_from_stage_per_file('@HEALTHCAREDB.BRONZE.HEALTHCAREDB_STAGE','.*') %}


SELECT 1 AS dummy_column