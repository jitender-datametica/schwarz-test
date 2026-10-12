CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_rcpt_coupon_promo_discount_ldpl_day_1 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), geo_area_sid OPTIONS(description='Ceographical identifier for client'),
dwh_cal_dt OPTIONS(description='Data date'), cy_month OPTIONS(description='Calendar_1 Year+Month in form YYYYMM'),
cy_month_prev_1m
OPTIONS(description='The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y
OPTIONS(description='The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
busyear_qtr OPTIONS(description='Business year quarter identifier'), wk_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), wk_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), wk_st_segment_sid
OPTIONS(description='ids of STRATEGIC segments from rfm model'), wk_fr_segment_sid
OPTIONS(description='ids of FREQUENCY segments from rfm model'), wk_re_segment_sid
OPTIONS(description='ids of RECENCY segments from rfm model'), wk_mo_segment_sid
OPTIONS(description='ids of NEW monetary segments from rfm model'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), mth_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), mth_st_segment_sid
OPTIONS(description='ids of STRATEGIC segments from rfm model'), mth_fr_segment_sid
OPTIONS(description='ids of FREQUENCY segments from rfm model'), mth_re_segment_sid
OPTIONS(description='ids of RECENCY segments from rfm model'), mth_mo_segment_sid
OPTIONS(description='ids of NEW monetary segments from rfm model'), busyear_qtr_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), busyear_qtr_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), loc_sid OPTIONS(description='Store ID'),
coupon_promo_sid
OPTIONS(description='Unique identifier of the coupon_promotion (surrogate key in t_coupon_promotion_hist. Default value for Sonstige -2)'),
move_to_store_id OPTIONS(description='Filialnummer nach letztem Filialumzug'), wh_id OPTIONS(description='Warehouse ID'),
lidlplus_cust_fg OPTIONS(description='Lidl Plus Customer Flag'), customer_sid OPTIONS(description='Customer identifier'),
currency_iso_cd OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'), feature_id
OPTIONS(description='Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid based on SCRM NN.dim_promotion.promotion_type_description'),
coupon_type_id
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid based on SCRM L1.promotionhst.category'),
discount_sid OPTIONS(description='Rabattgrund - Code; WAWI-DWH: t_ejr_receiptline.discount_id'), discount_type_id
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type'),
register_id OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_receiptheader.pos_terminal_id'), receipt_id
OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_receiptheader.orig_receipt_nr_ejr'), item_sid
OPTIONS(description='Item_1 surrogate ID (uniquely across all countries/clients)'), ean_barcode
OPTIONS(description='European Article Number'), pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
coupon_reason_nr OPTIONS(description='Identifier of the booking reason in SCRM'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
discount_val OPTIONS(description='Discount value'), writeoff_val OPTIONS(description='Writeoff net value'),
receipt_total_net_val_uniq
OPTIONS(description='Total net value of the whole Receipt as NUMERIC(29,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key. Used for Sum(Distinct receipt_total_net_val_uniq)'),
receipt_item_discount_piece_weight_qty_uniq
OPTIONS(description='Unit_1 Sold - Sales_1 (in units/kg) per item_sid as NUMERIC(29,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key + item_sid. Used for Sum Distinct'),
receipt_total_net_val_item_uniq
OPTIONS(description='Total net value per article levelcasted as NUMERIC(29,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key. Used for Sum(Distinct receipt_total_net_val_item_uniq)'),
redemptions_cnt_uniq
OPTIONS(description='Unique redemtion hash per client_id, dwh_cal_dt, loc_sid, receipt_id, register_id, p_lew_core.t_scrm_receiptline.src_coupon_promo_nr'),
coupon_cnt_uniq
OPTIONS(description='Unique coupon hash per client_id, p_lew_core.t_scrm_receiptline.src_coupon_promo_nr'),
coupon_source_id
OPTIONS(description='Coupon source: 0 - core receipt + core SCRM receipt (p_lew_core_ac.v_scrm_receiptline_1), 1 - only core receipt'),
load_id OPTIONS(description='Load identifier'), dwh_inserted OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time'), dwh_attr_updated OPTIONS(description='Row attributes update time')) AS SELECT F
 .aspect_id,
 F.client_id,
 F.geo_area_sid,
 F.dwh_cal_dt,
 F.cy_month,
 F.cy_month_prev_1m,
 F.cy_month_prev_1y,
 F.cy_week,
 F.cy_week_prev_1w,
 F.cy_week_prev_1y,
 F.busyear_qtr,
 F.wk_rf_segment_sid,
 F.wk_m_segment_sid,
 F.wk_st_segment_sid,
 F.wk_fr_segment_sid,
 F.wk_re_segment_sid,
 F.wk_mo_segment_sid,
 F.mth_rf_segment_sid,
 F.mth_m_segment_sid,
 F.mth_st_segment_sid,
 F.mth_fr_segment_sid,
 F.mth_re_segment_sid,
 F.mth_mo_segment_sid,
 F.busyear_qtr_rf_segment_sid,
 F.busyear_qtr_m_segment_sid,
 F.loc_sid,
 F.coupon_promo_sid,
 F.move_to_store_id,
 F.wh_id,
 F.lidlplus_cust_fg,
 F.customer_sid,
 F.currency_iso_cd,
 F.curr_tot_id,
 F.feature_id,
 F.coupon_type_id,
 F.discount_sid,
 F.discount_type_id,
 F.register_id,
 F.receipt_id,
 F.item_sid,
 F.ean_barcode,
 F.pcwo_reason_id,
 F.coupon_reason_nr,
 COLLATE(COALESCE(D.gender_cd, 'N/A'), '') AS gender_cd,
 COLLATE(COALESCE(D.age_range_cd, 'N/A'), '') AS age_range_cd,
 COALESCE(D.household_type_id, 0) AS household_type_id,
 COALESCE(D.child_age_range_group_id, 0) AS child_age_range_group_id,
 F.discount_val,
 F.writeoff_val,
 F.receipt_total_net_val_uniq,
 F.receipt_item_discount_piece_weight_qty_uniq,
 F.receipt_total_net_val_item_uniq,
 F.redemptions_cnt_uniq,
 F.coupon_cnt_uniq,
 F.coupon_source_id,
 F.load_id,
 F.dwh_inserted,
 F.dwh_updated,
 F.dwh_attr_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_rcpt_coupon_promo_discount_ldpl_day_1 AS F
 LEFT JOIN ldl_p_lew_mart_lidl_digital.t_cust_demogr_1 AS D ON F.customer_sid = D.customer_sid AND F.lidlplus_cust_fg =
   'Y';