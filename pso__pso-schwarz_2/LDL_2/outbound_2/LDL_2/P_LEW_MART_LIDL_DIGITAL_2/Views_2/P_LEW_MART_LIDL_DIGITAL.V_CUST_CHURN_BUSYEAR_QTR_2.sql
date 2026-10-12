/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-04-24 Rafal Rudnik             T_CUST_CHURN_MTH_2
#                                          Initial version SD-639
#  1.1 2024-11-06 Pawel Wieczorek          AP0228067 Lidl Plus Churn Metrics
#  1.2 2024-11-13 Pawel Wieczorek          AP0228067 Added column busyear_qtr_prev_1q
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_cust_churn_busyear_qtr_2 (client_id
OPTIONS(description='Identifier for client'), geo_area_sid OPTIONS(description='Ceographical identifier for client'),
busyear_qtr OPTIONS(description='Business year quarter identifier'), busyear_qtr_prev_1q
OPTIONS(description='Quarter of the business one quarter ago'), busyear_qtr_prev_1y
OPTIONS(description='Business year quarter identifier 1 year ago'), busyear_qtr_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), busyear_qtr_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
customer_sid OPTIONS(description='Customer identifier'), app_churn_busyear_qtr_30_days
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
store_churn_busyear_qtr_30_day
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
app_churn_busyear_qtr_90_days
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
store_churn_busyear_qtr_90_day
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS TABLE :  KPIS SHOW THE LIDL PLUS STORE OR APP CHURN PER BUSINESS YEAR QUARTER`) AS
SELECT client_id,
 geo_area_sid,
 busyear_qtr,
 busyear_qtr_prev_1q,
 busyear_qtr_prev_1y,
 busyear_qtr_m_segment_sid,
 busyear_qtr_rf_segment_sid,
 gender_cd,
 age_range_cd,
 household_type_id,
 child_age_range_group_id,
 customer_sid,
 app_churn_busyear_qtr_30_days,
 store_churn_busyear_qtr_30_days AS store_churn_busyear_qtr_30_day,
 app_churn_busyear_qtr_90_days,
 store_churn_busyear_qtr_90_days AS store_churn_busyear_qtr_90_day,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_cust_churn_busyear_qtr_2 AS T;