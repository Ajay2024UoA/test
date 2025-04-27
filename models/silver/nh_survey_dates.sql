{{
  config(
    materialized="table",
    schema=set_schema_based_on_folder()
  )
}}
SELECT DISTINCT
    TYPE_OF_SURVEY, 
    PROCESSING_DATE, 
    SURVEY_DATE, 
    REPORT_MONTH, 
    REPORT_DATE, 
    CMS_CERTIFICATION_NUMBER_CCN, 
    SURVEY_CYCLE
FROM {{ source('BRONZE', 'NH_SURVEY_DATES') }}
