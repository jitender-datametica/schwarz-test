/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2022-12-15 Pawel Wieczorek         AP0133752 Article Hierarchy_2 Initial version
#  1.1 2023-01-12 Pawel Wieczorek         AP0133752 Added CY_MONTH, CY_MONTH_PREV_1M, CY_MONTH_PREV_1Y, CY_WEEK, CY_WEEK_PREV_1W, CY_WEEK_PREV_1Y
#  1.2 2023-02-02 Pawel Wieczorek         AP0133752 Changed all columns to NOT NULL
#  1.3 2023-04-06 Rafal Rudnik            AP0133752 Changed add column: ean_barcode
#  1.4 2023-06-19 Pawel Wieczorek         AP0133752 Changed precission for TOTAL_NET_VAL and DISCOUNT_VAL to 25,10
#  1.5 2023-08-11 Pawel Wieczorek         AP0157806 booking reasons Added PCWO_SOURCE_ID, PCWO_REASON_ID, COUPON_REASON_NR and WRITEOFF_VAL, next time remove PRICE_CHANGE_FG 
#  1.6 2023-10-27 Pawel Wieczorek         AP0069622 Added CUSTOMER_SID
#  1.7 2024-06-26 Marcin Kikola           Fix for rfm segments
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_client_store_item_ldpl_day_2 (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
geo_area_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Identifier for geographical country_2'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Calendar_2 Year+Month in form YYYYMM'),
cy_month_prev_1m BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_2 year. Week 1 is the first week in the calendar_2 year containing at least 4 days.    [Week Identifier]'),
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
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID after last store relocation'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item_2 surrogate ID (uniquely across all countries/clients)'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
lidlplus_discount_fg STRING(1) NOT NULL OPTIONS(description='Lidplus discount flag'),
price_change_fg STRING(1) NOT NULL OPTIONS(description='Price change flag'),
pcwo_source_id BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Price change or writeoff source, 0 - receiptheader, 1 - discount, 2 - price change, 3 - writeoff'),
pcwo_reason_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_2-specific write-off reasons have ID>100.'),
coupon_reason_nr BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Identifier of the booking reason in SCRM'),
ean_barcode STRING(100) OPTIONS(description='EAN_2 Barcode'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
customer_sid BIGNUMERIC(38,0) DEFAULT - 999999999 NOT NULL OPTIONS(description='Customer identifier'),
total_net_val BIGNUMERIC(25,10) NOT NULL OPTIONS(description='Total net value'),
discount_val BIGNUMERIC(25,10) NOT NULL OPTIONS(description='Discount value'),
writeoff_val BIGNUMERIC(25,10) DEFAULT 0 OPTIONS(description='Writeoff net value'),
sales_piece_weight_qty NUMERIC(18,5) NOT NULL OPTIONS(description='Unit_2 Sold - Sales_2 (in units/kg)'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (aspect_id, client_id, dwh_cal_dt, loc_sid, item_sid, curr_tot_id, pcwo_reason_id, coupon_reason_nr,
 customer_sid) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Lidlplus : Receipt line aggregated to day, client, store and item_2 level');