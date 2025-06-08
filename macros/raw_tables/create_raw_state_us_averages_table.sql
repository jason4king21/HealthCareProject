
{% macro create_raw_state_us_averages_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.STATE_US_AVERAGES (
    "State_or_Nation" STRING,
    "Cycle_1_Total_Number_of_Health_Deficiencies" FLOAT,
    "Cycle_1_Total_Number_of_Fire_Safety_Deficiencies" FLOAT,
    "Cycle_2_Total_Number_of_Health_Deficiencies" FLOAT,
    "Cycle_2_Total_Number_of_Fire_Safety_Deficiencies" FLOAT,
    "Cycle_3_Total_Number_of_Health_Deficiencies" FLOAT,
    "Cycle_3_Total_Number_of_Fire_Safety_Deficiencies" FLOAT,
    "Average_Number_of_Residents_per_Day" FLOAT,
    "Reported_Nurse_Aide_Staffing_Hours_per_Resident_per_Day" FLOAT,
    "Reported_LPN_Staffing_Hours_per_Resident_per_Day" FLOAT,
    "Reported_RN_Staffing_Hours_per_Resident_per_Day" FLOAT,
    "Reported_Licensed_Staffing_Hours_per_Resident_per_Day" FLOAT,
    "Reported_Total_Nurse_Staffing_Hours_per_Resident_per_Day" FLOAT,
    "Total_number_of_nurse_staff_hours_per_resident_per_day_on_the_weekend" FLOAT,
    "Registered_Nurse_hours_per_resident_per_day_on_the_weekend" FLOAT,
    "Reported_Physical_Therapist_Staffing_Hours_per_Resident_Per_Day" FLOAT,
    "Total_nursing_staff_turnover" FLOAT,
    "Registered_Nurse_turnover" FLOAT,
    "Number_of_administrators_who_have_left_the_nursing_home" FLOAT,
    "Nursing_Case_Mix_Index" FLOAT,
    "Case_Mix_RN_Staffing_Hours_per_Resident_per_Day" FLOAT,
    "Case_Mix_Total_Nurse_Staffing_Hours_per_Resident_per_Day" FLOAT,
    "Case_Mix_Weekend_Total_Nurse_Staffing_Hours_per_Resident_per_Day" FLOAT,
    "Number_of_Fines" FLOAT,
    "Fine_Amount_in_Dollars" NUMBER,
    "Percentage_of_long_stay_residents_whose_need_for_help_with_daily_activities_has_increased" FLOAT,
    "Percentage_of_long_stay_residents_who_lose_too_much_weight" FLOAT,
    "Percentage_of_low_risk_long_stay_residents_who_lose_control_of_their_bowels_or_bladder" FLOAT,
    "Percentage_of_long_stay_residents_with_a_catheter_inserted_and_left_in_their_bladder" FLOAT,
    "Percentage_of_long_stay_residents_with_a_urinary_tract_infection" FLOAT,
    "Percentage_of_long_stay_residents_who_have_depressive_symptoms" FLOAT,
    "Percentage_of_long_stay_residents_who_were_physically_restrained" FLOAT,
    "Percentage_of_long_stay_residents_experiencing_one_or_more_falls_with_major_injury" FLOAT,
    "Percentage_of_long_stay_residents_assessed_and_appropriately_given_the_pneumococcal_vaccine" FLOAT,
    "Percentage_of_long_stay_residents_who_received_an_antipsychotic_medication" FLOAT,
    "Percentage_of_short_stay_residents_assessed_and_appropriately_given_the_pneumococcal_vaccine" FLOAT,
    "Percentage_of_short_stay_residents_who_newly_received_an_antipsychotic_medication" FLOAT,
    "Percentage_of_long_stay_residents_whose_ability_to_move_independently_worsened" FLOAT,
    "Percentage_of_long_stay_residents_who_received_an_antianxiety_or_hypnotic_medication" FLOAT,
    "Percentage_of_high_risk_long_stay_residents_with_pressure_ulcers" FLOAT,
    "Percentage_of_long_stay_residents_assessed_and_appropriately_given_the_seasonal_influenza_vaccine" FLOAT,
    "Percentage_of_short_stay_residents_who_made_improvements_in_function" FLOAT,
    "Percentage_of_short_stay_residents_who_were_assessed_and_appropriately_given_the_seasonal_influenza_vaccine" FLOAT,
    "Percentage_of_short_stay_residents_who_were_rehospitalized_after_a_nursing_home_admission" FLOAT,
    "Percentage_of_short_stay_residents_who_had_an_outpatient_emergency_department_visit" FLOAT,
    "Number_of_hospitalizations_per_1000_long_stay_resident_days" FLOAT,
    "Number_of_outpatient_emergency_department_visits_per_1000_long_stay_resident_days" FLOAT,
    "Processing_Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
