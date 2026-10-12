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


CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_CUST_APP_SESSION_LDPL_DAY 
COMMENT = 'Lidlplus : Lidl Plus customers application activity'
(
 aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
,geo_area_sid                   COMMENT 'Identifier for geographical country'
,client_id                      COMMENT 'Identifier for client'
,customer_sid                   COMMENT 'Surrogate Key CUSTOMER'
,dwh_cal_dt                     COMMENT 'Data date'
,cy_month                       COMMENT 'Calendar Year+Month in form YYYYMM'
,cy_month_prev_1m               COMMENT 'The calendar month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'
,cy_month_prev_1y               COMMENT 'The calendar month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'
,cy_week                        COMMENT 'The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.    [Week Identifier]'
,cy_week_prev_1w                COMMENT 'The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'
,cy_week_prev_1y                COMMENT 'The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'
,busyear_qtr                    COMMENT 'Identifier of the quarter of the busines year'
,wk_rf_segment_sid              COMMENT 'ids of recency-frequency segments from rfm model'
,wk_m_segment_sid               COMMENT 'ids of monetary segments from rfm model'
,mth_rf_segment_sid             COMMENT 'ids of recency-frequency segments from rfm model'
,mth_m_segment_sid              COMMENT 'ids of monetary segments from rfm model'
,busyear_qtr_rf_segment_sid     COMMENT 'ids of recency-frequency segments from rfm model'
,busyear_qtr_m_segment_sid      COMMENT 'ids of monetary segments from rfm model'
,gender_cd                      COMMENT 'The code for the gender'
,age_range_cd                   COMMENT 'The code for the age range.'
,household_type_id              COMMENT 'ID of the household type in which the customer lives.'
,child_age_range_group_id       COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.'
,app_version_os_nr              COMMENT 'Application version os number'
,app_session_sid                COMMENT 'Surrogate Key for Application session'
,load_id                        COMMENT 'Load identifier'
,dwh_created                    COMMENT 'Row created time'
,dwh_updated                    COMMENT 'Row update time'
)
AS
SELECT
 t.aspect_id
,t.geo_area_sid
,t.client_id
,t.customer_sid
,t.dwh_cal_dt
,t.cy_month
,t.cy_month_prev_1m
,t.cy_month_prev_1y
,t.cy_week
,t.cy_week_prev_1w
,t.cy_week_prev_1y
,t.busyear_qtr
,t.wk_rf_segment_sid
,t.wk_m_segment_sid
,t.mth_rf_segment_sid
,t.mth_m_segment_sid
,t.busyear_qtr_rf_segment_sid
,t.busyear_qtr_m_segment_sid
,t.gender_cd
,t.age_range_cd
,t.household_type_id
,t.child_age_range_group_id
,t.app_version_os_nr
,t.app_session_sid
,t.load_id
,t.dwh_created
,t.dwh_updated
FROM p_lew_mart_lidl_digital.v_agg_cust_app_session_ldpl_day AS t
;


