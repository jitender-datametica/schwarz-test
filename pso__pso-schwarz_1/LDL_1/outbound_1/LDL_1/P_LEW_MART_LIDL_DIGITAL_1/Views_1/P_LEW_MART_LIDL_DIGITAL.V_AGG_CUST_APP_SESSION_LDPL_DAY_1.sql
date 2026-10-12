/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-04-16 Pawel Wieczorek    Initial version AP0269926
#  1.1 2025-04-29 Pawel Wieczorek    AP0269926 Added audit columns
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_cust_app_session_ldpl_day_1 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), geo_area_sid
OPTIONS(description='Identifier for geographical country_1'), client_id OPTIONS(description='Identifier for client'),
customer_sid OPTIONS(description='Surrogate Key CUSTOMER'), dwh_cal_dt OPTIONS(description='Data date'), cy_month
OPTIONS(description='Calendar_1 Year+Month in form YYYYMM'), cy_month_prev_1m
OPTIONS(description='The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y
OPTIONS(description='The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
busyear_qtr OPTIONS(description='Identifier of the quarter of the busines year'), wk_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), wk_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), mth_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), busyear_qtr_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), busyear_qtr_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), gender_cd OPTIONS(description='The code for the gender'),
age_range_cd OPTIONS(description='The code for the age range.'), household_type_id
OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
app_version_os_nr OPTIONS(description='Application version os number'), app_session_sid
OPTIONS(description='Surrogate Key for Application session'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row created time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : LIDL PLUS CUSTOMERS APPLICATION ACTIVITY`) AS SELECT T.aspect_id,
 T.geo_area_sid,
 T.client_id,
 T.customer_sid,
 T.dwh_cal_dt,
 T.cy_month,
 T.cy_month_prev_1m,
 T.cy_month_prev_1y,
 T.cy_week,
 T.cy_week_prev_1w,
 T.cy_week_prev_1y,
 T.busyear_qtr,
 T.wk_rf_segment_sid,
 T.wk_m_segment_sid,
 T.mth_rf_segment_sid,
 T.mth_m_segment_sid,
 T.busyear_qtr_rf_segment_sid,
 T.busyear_qtr_m_segment_sid,
 COLLATE(COALESCE(D.gender_cd, 'N/A'), '') AS gender_cd,
 COLLATE(COALESCE(D.age_range_cd, 'N/A'), '') AS age_range_cd,
 COALESCE(D.household_type_id, 0) AS household_type_id,
 COALESCE(D.child_age_range_group_id, 0) AS child_age_range_group_id,
 T.app_version_os_nr,
 T.app_session_sid,
 T.load_id,
 T.dwh_created,
 T.dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_cust_app_session_ldpl_day_1 AS T
 LEFT JOIN ldl_p_lew_mart_lidl_digital.t_cust_demogr_1 AS D ON T.customer_sid = D.customer_sid;