{{
  config(
    materialized="table",
    schema=set_schema_based_on_folder()
  )
}}
SELECT
CASE_MIX_RN_STAFFING_HOURS_PER_RESIDENT_PER_DAY, 
REPORTED_LICENSED_STAFFING_HOURS_PER_RESIDENT_PER_DAY, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_EXPERIENCING_ONE_OR_MORE_FALLS_WITH_MAJOR_INJURY, 
REPORTED_TOTAL_NURSE_STAFFING_HOURS_PER_RESIDENT_PER_DAY, 
PERCENTAGE_OF_SHORT_STAY_RESIDENTS_WHO_WERE_REHOSPITALIZED_AFTER_A_NURSING_HOME_ADMISSION, 
TOTAL_NUMBER_OF_NURSE_STAFF_HOURS_PER_RESIDENT_PER_DAY_ON_THE_WEEKEND, 
CYCLE_1_TOTAL_NUMBER_OF_HEALTH_DEFICIENCIES, 
NUMBER_OF_OUTPATIENT_EMERGENCY_DEPARTMENT_VISITS_PER_1000_LONG_STAY_RESIDENT_DAYS, 
FINE_AMOUNT_IN_DOLLARS, NUMBER_OF_ADMINISTRATORS_WHO_HAVE_LEFT_THE_NURSING_HOME, 
REPORTED_RN_STAFFING_HOURS_PER_RESIDENT_PER_DAY, CYCLE_3_TOTAL_NUMBER_OF_HEALTH_DEFICIENCIES, 
--REPORT_DATE, 
AVERAGE_NUMBER_OF_RESIDENTS_PER_DAY, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WHO_RECEIVED_AN_ANTIANXIETY_OR_HYPNOTIC_MEDICATION, 
REGISTERED_NURSE_HOURS_PER_RESIDENT_PER_DAY_ON_THE_WEEKEND, 
CASE_MIX_TOTAL_NURSE_STAFFING_HOURS_PER_RESIDENT_PER_DAY, 
PERCENTAGE_OF_HIGH_RISK_LONG_STAY_RESIDENTS_WITH_PRESSURE_ULCERS, 
CASE_MIX_WEEKEND_TOTAL_NURSE_STAFFING_HOURS_PER_RESIDENT_PER_DAY, 
--REPORT_MONTH, 
STATE_OR_NATION, 
NUMBER_OF_HOSPITALIZATIONS_PER_1000_LONG_STAY_RESIDENT_DAYS, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WHO_RECEIVED_AN_ANTIPSYCHOTIC_MEDICATION, 
REPORTED_LPN_STAFFING_HOURS_PER_RESIDENT_PER_DAY, 
CYCLE_2_TOTAL_NUMBER_OF_HEALTH_DEFICIENCIES, 
REGISTERED_NURSE_TURNOVER, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WHOSE_ABILITY_TO_MOVE_INDEPENDENTLY_WORSENED, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WHO_LOSE_TOO_MUCH_WEIGHT, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WHO_HAVE_DEPRESSIVE_SYMPTOMS, 
TOTAL_NURSING_STAFF_TURNOVER, 
PERCENTAGE_OF_LOW_RISK_LONG_STAY_RESIDENTS_WHO_LOSE_CONTROL_OF_THEIR_BOWELS_OR_BLADDER, 
PERCENTAGE_OF_SHORT_STAY_RESIDENTS_WHO_WERE_ASSESSED_AND_APPROPRIATELY_GIVEN_THE_SEASONAL_INFLUENZA_VACCINE, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WITH_A_CATHETER_INSERTED_AND_LEFT_IN_THEIR_BLADDER, 
PERCENTAGE_OF_SHORT_STAY_RESIDENTS_WHO_NEWLY_RECEIVED_AN_ANTIPSYCHOTIC_MEDICATION, 
REPORTED_PHYSICAL_THERAPIST_STAFFING_HOURS_PER_RESIDENT_PER_DAY, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_ASSESSED_AND_APPROPRIATELY_GIVEN_THE_SEASONAL_INFLUENZA_VACCINE, 
REPORTED_NURSE_AIDE_STAFFING_HOURS_PER_RESIDENT_PER_DAY, 
NURSING_CASE_MIX_INDEX, NUMBER_OF_FINES, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WITH_A_URINARY_TRACT_INFECTION, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WHOSE_NEED_FOR_HELP_WITH_DAILY_ACTIVITIES_HAS_INCREASED, 
CYCLE_2_TOTAL_NUMBER_OF_FIRE_SAFETY_DEFICIENCIES, CYCLE_1_TOTAL_NUMBER_OF_FIRE_SAFETY_DEFICIENCIES, 
PERCENTAGE_OF_SHORT_STAY_RESIDENTS_WHO_HAD_AN_OUTPATIENT_EMERGENCY_DEPARTMENT_VISIT, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_ASSESSED_AND_APPROPRIATELY_GIVEN_THE_PNEUMOCOCCAL_VACCINE, 
PERCENTAGE_OF_SHORT_STAY_RESIDENTS_WHO_MADE_IMPROVEMENTS_IN_FUNCTION, 
PERCENTAGE_OF_SHORT_STAY_RESIDENTS_ASSESSED_AND_APPROPRIATELY_GIVEN_THE_PNEUMOCOCCAL_VACCINE, 
PERCENTAGE_OF_LONG_STAY_RESIDENTS_WHO_WERE_PHYSICALLY_RESTRAINED, 
CYCLE_3_TOTAL_NUMBER_OF_FIRE_SAFETY_DEFICIENCIES, 
PROCESSING_DATE
FROM {{ source('BRONZE', 'NH_STATE_US_AVERAGES') }}
