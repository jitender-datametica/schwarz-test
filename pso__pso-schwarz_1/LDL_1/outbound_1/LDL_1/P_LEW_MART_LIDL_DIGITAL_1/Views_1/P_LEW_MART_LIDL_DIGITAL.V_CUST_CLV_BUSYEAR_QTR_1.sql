CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_cust_clv_busyear_qtr_1 (client_id
OPTIONS(description='Identifier for client'), geo_area_sid OPTIONS(description='Ceographical identifier for client'),
currency_iso_cd OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'), busyear_qtr
OPTIONS(description='Business year quarter identifier'), busyear_qtr_prev_1q
OPTIONS(description='Quarter of the business one quarter ago'), busyear_qtr_prev_1y
OPTIONS(description='Business year quarter identifier 1 year ago'), busyear_qtr_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), busyear_qtr_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
customer_sid OPTIONS(description='Customer identifier'), clv_365_days
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `Lidlplus table :  KPIs show the Lidl Plus clv 365 per business year quarter`) AS SELECT client_id
 ,
 geo_area_sid,
 currency_iso_cd,
 curr_tot_id,
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
 clv_365_days,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_cust_clv_busyear_qtr_1 AS T;