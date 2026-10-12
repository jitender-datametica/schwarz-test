create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_RCPT_COUPON_PROMO_DISCOUNT_LDPL_DAY_2(
	ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	CLIENT_ID COMMENT 'Identifier for client',
	GEO_AREA_SID COMMENT 'Ceographical identifier for client',
	DWH_CAL_DT COMMENT 'Data date',
	CY_MONTH COMMENT 'Calendar_2 Year+Month in form YYYYMM',
	CY_MONTH_PREV_1M COMMENT 'The calendar_2 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]',
	CY_MONTH_PREV_1Y COMMENT 'The calendar_2 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]',
	CY_WEEK COMMENT 'The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_2 year. Week 1 is the first week in the calendar_2 year containing at least 4 days.    [Week Identifier]',
	CY_WEEK_PREV_1W COMMENT 'The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]',
	CY_WEEK_PREV_1Y COMMENT 'The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]',
	BUSYEAR_QTR COMMENT 'Business year quarter identifier',
	WK_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	WK_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	WK_ST_SEGMENT_SID COMMENT 'ids of STRATEGIC segments from rfm model',
	WK_FR_SEGMENT_SID COMMENT 'ids of FREQUENCY segments from rfm model',
	WK_RE_SEGMENT_SID COMMENT 'ids of RECENCY segments from rfm model',
	WK_MO_SEGMENT_SID COMMENT 'ids of NEW monetary segments from rfm model',
	MTH_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	MTH_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	MTH_ST_SEGMENT_SID COMMENT 'ids of STRATEGIC segments from rfm model',
	MTH_FR_SEGMENT_SID COMMENT 'ids of FREQUENCY segments from rfm model',
	MTH_RE_SEGMENT_SID COMMENT 'ids of RECENCY segments from rfm model',
	MTH_MO_SEGMENT_SID COMMENT 'ids of NEW monetary segments from rfm model',
	BUSYEAR_QTR_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	BUSYEAR_QTR_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	LOC_SID COMMENT 'Store ID',
	COUPON_PROMO_SID COMMENT 'Unique identifier of the coupon_promotion (surrogate key in t_coupon_promotion_hist. Default value for Sonstige -2)',
	MOVE_TO_STORE_ID COMMENT 'Filialnummer nach letztem Filialumzug',
	WH_ID COMMENT 'Warehouse ID',
	LIDLPLUS_CUST_FG COMMENT 'Lidl Plus Customer Flag',
	CUSTOMER_SID COMMENT 'Customer identifier',
	CURRENCY_ISO_CD COMMENT 'ISO code for the currency of the client.',
	CURR_TOT_ID COMMENT 'Fixe Werte fur EUR=0 GBP=40 sonst Client_Id',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	FEATURE_ID COMMENT 'Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid based on SCRM NN.dim_promotion.promotion_type_description',
	COUPON_TYPE_ID COMMENT 'Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid based on SCRM L1.promotionhst.category',
	DISCOUNT_TYPE_ID COMMENT 'Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type',
	REGISTER_ID COMMENT 'Kassennummer; WAWI-DWH: t_ejr_receiptheader.pos_terminal_id',
	RECEIPT_ID COMMENT 'Bon-Nummer; WAWI-DWH: t_ejr_receiptheader.orig_receipt_nr_ejr',
	ITEM_SID COMMENT 'Item_2 surrogate ID (uniquely across all countries/clients)',
	EAN_BARCODE COMMENT 'European Article Number',
	PCWO_REASON_ID COMMENT 'Unique ID of the write-off or Price change reason. Country_2-specific write-off reasons have ID>100.',
	COUPON_REASON_NR COMMENT 'Identifier of the booking reason in SCRM',
	DISCOUNT_SID COMMENT 'Rabattgrund - Code; WAWI-DWH: t_ejr_receiptline.discount_id',
	DISCOUNT_VAL COMMENT 'Discount value',
	WRITEOFF_VAL COMMENT 'Writeoff net value',
	RECEIPT_TOTAL_NET_VAL_UNIQ COMMENT 'Total net value of the whole Receipt as Decimal(18,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key. Used for Sum(Distinct receipt_total_net_val_uniq)',
	RECEIPT_ITEM_DISCOUNT_PIECE_WEIGHT_QTY_UNIQ COMMENT 'Unit_2 Sold - Sales_2 (in units/kg) per item_sid as Decimal(18,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key + item_sid. Used for Sum Distinct',
	RECEIPT_TOTAL_NET_VAL_ITEM_UNIQ COMMENT 'Total net value per article levelcasted as Decimal(18,5), concatenated with 000 and 17 digits of a MD5 on receipt Primary key. Used for Sum(Distinct receipt_total_net_val_item_uniq)',
	REDEMPTIONS_CNT_UNIQ COMMENT 'Unique redemtion hash per client_id, dwh_cal_dt, loc_sid, receipt_id, register_id, p_lew_core.t_scrm_receiptline.src_coupon_promo_nr',
	COUPON_CNT_UNIQ COMMENT 'Unique coupon hash per client_id, p_lew_core.t_scrm_receiptline.src_coupon_promo_nr',
	COUPON_SOURCE_ID COMMENT 'Coupon source: 0 - core receipt + core SCRM receipt (p_lew_core_ac.v_scrm_receiptline_2), 1 - only core receipt',
	LOAD_ID COMMENT 'Load identifier',
	DWH_INSERTED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time',
	DWH_ATTR_UPDATED COMMENT 'Row attributes update time'
) as
SELECT
 f.aspect_id
,f.client_id
,f.geo_area_sid
,f.dwh_cal_dt
,f.cy_month
,f.cy_month_prev_1m
,f.cy_month_prev_1y
,f.cy_week
,f.cy_week_prev_1w
,f.cy_week_prev_1y
,f.busyear_qtr
,f.wk_rf_segment_sid
,f.wk_m_segment_sid 
,f.wk_st_segment_sid
,f.wk_fr_segment_sid
,f.wk_re_segment_sid
,f.wk_mo_segment_sid
,f.mth_rf_segment_sid
,f.mth_m_segment_sid
,f.mth_st_segment_sid
,f.mth_fr_segment_sid
,f.mth_re_segment_sid
,f.mth_mo_segment_sid
,f.busyear_qtr_rf_segment_sid
,f.busyear_qtr_m_segment_sid
,f.loc_sid
,f.coupon_promo_sid
,f.move_to_store_id
,f.wh_id
,f.lidlplus_cust_fg
,f.customer_sid
,f.currency_iso_cd
,f.curr_tot_id
,f.gender_cd
,f.age_range_cd
,f.household_type_id
,f.child_age_range_group_id 
,f.feature_id
,f.coupon_type_id
,f.discount_type_id
,f.register_id
,f.receipt_id
,f.item_sid
,f.ean_barcode
,f.pcwo_reason_id 
,f.coupon_reason_nr 
,f.discount_sid
,f.discount_val 
,f.writeoff_val 
,f.receipt_total_net_val_uniq
,f.receipt_item_discount_piece_weight_qty_uniq
,f.receipt_total_net_val_item_uniq
,f.redemptions_cnt_uniq
,f.coupon_cnt_uniq
,f.coupon_source_id
,f.load_id
,f.dwh_inserted
,f.dwh_updated
,f.dwh_attr_updated
FROM p_lew_mart_lidl_digital.v_agg_rcpt_coupon_promo_discount_ldpl_day_2 AS f
;
