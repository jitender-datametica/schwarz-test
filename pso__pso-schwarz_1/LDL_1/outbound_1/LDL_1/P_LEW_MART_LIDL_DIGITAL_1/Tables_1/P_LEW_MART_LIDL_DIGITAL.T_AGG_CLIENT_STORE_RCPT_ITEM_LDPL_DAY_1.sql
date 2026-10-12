/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2023-11-20 Marcin Kikola           AP0150474 Article Hierarchy_1 Initial version
#  1.1 2024-06-26 Marcin Kikola           Fix for rfm segments
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_client_store_rcpt_item_ldpl_day_1 (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
geo_area_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Identifier for geographical country_1'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Calendar_1 Year+Month in form YYYYMM'),
cy_month_prev_1m BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
busyear_qtr BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Identifier of the quarter of the busines year'),
wk_rf_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='ids of recency-frequency segments from rfm model'),
wk_m_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
mth_rf_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_m_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
busyear_qtr_rf_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='ids of recency-frequency segments from rfm model'),
busyear_qtr_m_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='ids of monetary segments from rfm model'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item_1 surrogate ID (uniquely across all countries/clients)'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
ean_barcode STRING(100) OPTIONS(description='EAN_1 Barcode'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
receipt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for receipt'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier of a cashier'),
receipt_cnt_uniq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique Receipt combination used for count distinct in Microstrategy '),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (aspect_id, client_id, dwh_cal_dt, loc_sid, item_sid, customer_sid, receipt_id, register_id) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Lidlplus : Table that is source for count of receipts and customers in context of day, client, store and item_1 dimensions');