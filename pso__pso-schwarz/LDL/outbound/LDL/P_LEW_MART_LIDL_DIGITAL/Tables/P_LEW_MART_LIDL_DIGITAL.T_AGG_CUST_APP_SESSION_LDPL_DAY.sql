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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_cust_app_session_ldpl_day (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for geographical country'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Calendar Year+Month in form YYYYMM'),
cy_month_prev_1m BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
busyear_qtr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier of the quarter of the busines year'),
wk_rf_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
wk_m_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
mth_rf_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_m_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
busyear_qtr_rf_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ids of recency-frequency segments from rfm model'),
busyear_qtr_m_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
app_version_os_nr STRING(100) NOT NULL OPTIONS(description='Application version os number'),
app_session_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for Application session'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, geo_area_sid, customer_sid, dwh_cal_dt, app_version_os_nr) NOT ENFORCED
) OPTIONS(description='Lidlplus : Lidl Plus customers application activity');