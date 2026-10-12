DROP TABLE IF EXISTS ldl_p_lew_mart_lidl_digital.t_agg_client_store_item_ldpl_day;
CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_agg_client_store_item_ldpl_day (
aspect_id INTEGER NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id INTEGER NOT NULL OPTIONS(description='Identifier for client'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
cy_month INTEGER NOT NULL OPTIONS(description='Calendar Year+Month in form YYYYMM'),
cy_month_prev_1m INTEGER NOT NULL
OPTIONS(description='The calendar month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y INTEGER NOT NULL
OPTIONS(description='The calendar month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week INTEGER NOT NULL
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w INTEGER NOT NULL
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y INTEGER NOT NULL
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
loc_sid INTEGER NOT NULL OPTIONS(description='Store ID'),
move_to_store_id INTEGER NOT NULL OPTIONS(description='Store ID after last store relocation'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse ID'),
item_sid INTEGER NOT NULL OPTIONS(description='Item surrogate ID (uniquely across all countries/clients)'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
lidlplus_discount_fg STRING(1) NOT NULL OPTIONS(description='Lidplus discount flag'),
price_change_fg STRING(1) NOT NULL OPTIONS(description='Price change flag'),
ean_barcode STRING(100) OPTIONS(description='EAN Barcode'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id INTEGER NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
total_net_val BIGNUMERIC(38,10) NOT NULL OPTIONS(description='Total net value'),
discount_val BIGNUMERIC(38,10) NOT NULL OPTIONS(description='Discount value'),
sales_piece_weight_qty NUMERIC(29,5) NOT NULL OPTIONS(description='Unit Sold - Sales (in units/kg)'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
pcwo_source_id INTEGER DEFAULT 0
OPTIONS(description='Price change or writeoff source, 0 - receiptheader, 1 - discount, 2 - price change, 3 - writeoff'),
pcwo_reason_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Unique ID of the write-off or Price change reason. Country-specific write-off reasons have ID>100.'),
coupon_reason_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Identifier of the booking reason in SCRM'),
writeoff_val BIGNUMERIC(38,10) DEFAULT 0 OPTIONS(description='Writeoff net value'),
customer_sid INTEGER DEFAULT -999999999 NOT NULL OPTIONS(description='Customer identifier'),
geo_area_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Identifier for geographical country'),
busyear_qtr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Identifier of the quarter of the busines year'),
wk_rf_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of recency-frequency segments from rfm model'),
wk_m_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of monetary segments from rfm model'),
mth_rf_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_m_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of monetary segments from rfm model'),
busyear_qtr_rf_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of recency-frequency segments from rfm model'),
busyear_qtr_m_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of monetary segments from rfm model'),
wk_st_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new STRATEGIC segments from rfm model'),
wk_fr_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new FREQUENCY segments from rfm model'),
wk_re_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new RECENCY segments from rfm model'),
wk_mo_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new monetary segments from rfm model'),
mth_st_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new STRATEGIC segments from rfm model'),
mth_fr_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new FREQUENCY segments from rfm model'),
mth_re_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new RECENCY segments from rfm model'),
mth_mo_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new monetary segments from rfm model'),
PRIMARY KEY (aspect_id, client_id, dwh_cal_dt, loc_sid, item_sid, curr_tot_id, pcwo_reason_id, coupon_reason_nr,
 customer_sid) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Lidlplus : Receipt line aggregated to day, client, store and item level');