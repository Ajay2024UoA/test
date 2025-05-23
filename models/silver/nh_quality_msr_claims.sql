{{
  config(
    materialized="table",
    schema=set_schema_based_on_folder()
  )
}}
SELECT DISTINCT
    --REPORT_MONTH, 
    ZIP_CODE, 
    STATE, 
    USED_IN_QUALITY_MEASURE_FIVE_STAR_RATING, 
    OBSERVED_SCORE, 
    EXPECTED_SCORE, 
    ADJUSTED_SCORE, 
    RESIDENT_TYPE, 
    PROVIDER_NAME, 
    FOOTNOTE_FOR_SCORE, 
    CMS_CERTIFICATION_NUMBER_CCN, 
    CITY_TOWN, 
    LOCATION, 
    MEASURE_PERIOD, 
    MEASURE_DESCRIPTION, 
    PROVIDER_ADDRESS, 
    --REPORT_DATE, 
    PROCESSING_DATE, 
    MEASURE_CODE
FROM {{ source('BRONZE', 'NH_QUALITY_MSR_CLAIMS') }}
