{{
  config(
    materialized="table",
    schema=set_schema_based_on_folder()
  )
}}
SELECT 
 START_DATE,
  REPORT_MONTH, 
  CMS_REGION, 
  MEASURE_CODE, 
  MEASURE_DATE_RANGE, 
  REPORT_DATE, 
  ZIP_CODE, 
  END_DATE, 
  COUNTY_PARISH, 
  ADDRESS_LINE_1, 
  LOCATION1, 
  STATE, 
  CMS_CERTIFICATION_NUMBER_CCN, 
  CITY_TOWN, 
  PROVIDER_NAME, 
  FOOTNOTE, SCORE,
  TELEPHONE_NUMBER
FROM {{ source('BRONZE', 'SNF_QRP_PROVIDER_DATA') }}
