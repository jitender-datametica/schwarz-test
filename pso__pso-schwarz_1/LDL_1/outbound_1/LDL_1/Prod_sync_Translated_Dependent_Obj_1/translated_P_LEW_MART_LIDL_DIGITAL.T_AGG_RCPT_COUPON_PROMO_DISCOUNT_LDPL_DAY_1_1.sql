/*
 * History:
 * 
 * 1.0 2022-01-04 Pawel Wieczorek         #266102 Initial versions
 * 1.1 2022-01-24 Pawel Wieczorek         #266102 Remove space from comments - Table definitions must use trailing commas (test_table_comma_trailing) 
 * 1.2 2022-01-24 Pawel Wieczorek         #266102 Add column receipt_total_net_val_uniq
 * 1.3 2022-02-23 Pawel Wieczorek         #266102 Changed precistion and scale for receipt_total_net_val_uniq
 * 1.4 2022-02-24 Pawel Wieczorek         #266102 Revert changes for receipt_total_net_val_uniq
 * 1.5 2022-02-24 Pawel Wieczorek         #282119 Apply change 1.4 again
 * 1.6 2022-08-04 Pawel Wieczorek         AP0056182_coupon_promo_discount_2 #282119 changing precision for discount_val NUMBER(29,5) -> NUMBER(38,10) 
 * 1.7 2022-09-23 Marcin Kikola           AP0144589 external id logic added to the definition of the table. Coupon_promo_sid added as id for external id
 * 1.8 2023-01-23 Pawel Wieczorek         AP0133752 Artikel_1 Hierarchie part 1, New columns added: item_sid, ean_1 and discount quality, cm, pm_1, cym, cw, pw, pyw
 *                                        Changed cluster to the same as table in AC_MATERIALIZED schema used by MSTR
 * 1.9 2023-01-24 Pawel Wieczorek         AP0133752 Artikel_1 Hierarchie part 1  Adding default values to new columns
 * 2.0 2023-01-25 Pawel Wieczorek         AP0133752 Artikel_1 Hierarchie part 1  Remove not null for new columns
 * 2.1 2023-01-25 Pawel Wieczorek         AP0133752 Artikel_1 Hierarchie part 1  Restore NOT NULL for new columns
 * 2.1 2023-04-17 Marcin Kikola           AP0133752 Artikel_1 Hierarchie part 1  New column for Umsatz at level of article was added
 * 2.2 2023-05-22 Pawel Wieczorek         AP0157806 booking reasons Added pcwo_reason_id and coupon_reason_nr and writeoff_val
 * 2.3 2023-08-08 Pawel Wieczorek         AP0157806 restore cluster by from master branch
 * 2.4 2024-03-28 Pawel Wieczorek         AP0069628 Redemption - Added columns redemptions_cnt_uniq, discount_sid, coupon_source_id
 * 2.5 2024-05-02 Pawel Wieczorek         AP0220457_LP_Coupon_Count - Added columns coupon_cnt_uniq
 * 2.6 2024-06-26 Marcin Kikola           Fix for rfm segments
 * 2.7 2025-05-20 Pawel Wieczorek         AP0276065 Added column dwh_attr_updated, dwh_updated should not be updated for WFM export
#----------------------------------------------------------------
 */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_rcpt_coupon_promo_discount_ldpl_day_1 (
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
wk_rf_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
wk_m_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
mth_rf_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_m_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
busyear_qtr_rf_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='ids of recency-frequency segments from rfm model'),
busyear_qtr_m_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
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