DROP TABLE IF EXISTS ldl_p_lew_mart_lidl_digital.t_agg_rcpt_coupon_promo_discount_ldpl_day_1;
CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_agg_rcpt_coupon_promo_discount_ldpl_day_1 (
aspect_id INTEGER NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id INTEGER NOT NULL OPTIONS(description='Identifier for client'),
geo_area_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Identifier for geographical country_1'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
cy_month INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Calendar_1 Year+Month in form YYYYMM'),
cy_month_prev_1m INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
busyear_qtr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Identifier of the quarter of the busines year'),
wk_rf_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of recency-frequency segments from rfm model'),
wk_m_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of monetary segments from rfm model'),
wk_st_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of STRATEGIC segments from rfm model'),
wk_fr_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of FREQUENCY segments from rfm model'),
wk_re_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of RECENCY segments from rfm model'),
wk_mo_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of NEW monetary segments from rfm model'),
mth_rf_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_m_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of monetary segments from rfm model'),
mth_st_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of STRATEGIC segments from rfm model'),
mth_fr_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of FREQUENCY segments from rfm model'),
mth_re_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of RECENCY segments from rfm model'),
mth_mo_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of NEW monetary segments from rfm model'),
busyear_qtr_rf_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of recency-frequency segments from rfm model'),
busyear_qtr_m_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of monetary segments from rfm model'),
loc_sid INTEGER NOT NULL OPTIONS(description='Store ID'),
coupon_promo_sid INTEGER NOT NULL
OPTIONS(description='Unique identifier of the coupon_promotion (surrogate key in t_coupon_promotion_hist. Default value for Sonstige -2)'),
move_to_store_id INTEGER NOT NULL OPTIONS(description='Filialnummer nach letztem Filialumzug'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse ID'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidl Plus Customer Flag'),
customer_sid INTEGER NOT NULL OPTIONS(description='Customer identifier'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id INTEGER NOT NULL OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'),
feature_id INTEGER NOT NULL
OPTIONS(description='Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid based on SCRM NN.dim_promotion.promotion_type_description'),
coupon_type_id INTEGER NOT NULL
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid based on SCRM L1.promotionhst.category'),
discount_type_id INTEGER NOT NULL
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type'),
register_id INTEGER NOT NULL OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_receiptheader.pos_terminal_id'),
receipt_id INTEGER NOT NULL OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_receiptheader.orig_receipt_nr_ejr'),
item_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Item_1 surrogate ID (uniquely across all countries/clients)'),
ean_barcode STRING(100) OPTIONS(description='European Article Number'),
pcwo_reason_id INTEGER DEFAULT 0
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
coupon_reason_nr INTEGER DEFAULT 0 OPTIONS(description='Identifier of the booking reason in SCRM'),
discount_sid INTEGER OPTIONS(description='Rabattgrund - Code; WAWI-DWH: t_ejr_receiptline.discount_id'),
discount_val BIGNUMERIC(38,10) NOT NULL OPTIONS(description='Discount value'),
writeoff_val BIGNUMERIC(38,10) DEFAULT 0 OPTIONS(description='Writeoff net value'),
receipt_total_net_val_uniq BIGNUMERIC(38,25) NOT NULL
OPTIONS(description='Total net value of the whole Receipt as NUMERIC(29,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key. Used for Sum(Distinct receipt_total_net_val_uniq)'),
receipt_item_discount_piece_weight_qty_uniq BIGNUMERIC(38,25) DEFAULT 0 NOT NULL
OPTIONS(description='Unit_1 Sold - Sales_1 (in units/kg) per item_sid as NUMERIC(29,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key + item_sid. Used for Sum Distinct'),
receipt_total_net_val_item_uniq BIGNUMERIC(38,25)
OPTIONS(description='Total net value per article levelcasted as NUMERIC(29,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key. Used for Sum(Distinct receipt_total_net_val_item_uniq)'),
redemptions_cnt_uniq INTEGER
OPTIONS(description='Unique redemtion hash per client_id, dwh_cal_dt, loc_sid, receipt_id, register_id, p_lew_core.t_scrm_receiptline.src_coupon_promo_nr'),
coupon_cnt_uniq INTEGER
OPTIONS(description='Unique coupon hash per client_id, p_lew_core.t_scrm_receiptline.src_coupon_promo_nr'),
coupon_source_id INTEGER
OPTIONS(description='Coupon source: 0 - core receipt + core SCRM receipt (p_lew_core_ac.v_scrm_receiptline_1), 1 - only core receipt'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_inserted DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
dwh_attr_updated DATETIME OPTIONS(description='Row attributes update time'),
PRIMARY KEY (aspect_id, client_id, dwh_cal_dt, loc_sid, currency_iso_cd, feature_id, coupon_type_id, discount_type_id,
 register_id, receipt_id, item_sid) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Lidlplus : Receipt header coupon promotion discount aggregated to day level');