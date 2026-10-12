/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-11-06 Pawel Wieczorek          AP0228067 Lidl Plus Churn Metrics
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_cust_churn_wk (client_id
OPTIONS(description='Identifier for client'), geo_area_sid OPTIONS(description='Ceographical identifier for client'),
cy_week OPTIONS(description='Week number'), cy_week_prev_1w
OPTIONS(description='The calendar week 1 week ago as a number in the form YYYYWW.'), cy_week_prev_1y
OPTIONS(description='The calendar week 1 year ago as a number in the form YYYYWW.'), wk_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), wk_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), gender_cd OPTIONS(description='The code for the gender'),
age_range_cd OPTIONS(description='The code for the age range.'), household_type_id
OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
customer_sid OPTIONS(description='Customer identifier'), app_churn_wk_30_days
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
store_churn_wk_30_days
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
app_churn_wk_90_days
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
store_churn_wk_90_days
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS TABLE : KPIS SHOW THE LIDL PLUS STORE OR APP CHURN PER WEEK`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_cust_churn_wk AS T;