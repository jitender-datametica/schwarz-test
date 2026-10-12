create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_RCPT_HDR_LDPL_WK_2(
	ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	CLIENT_ID COMMENT 'Identifier for client',
	MOVE_TO_STORE_ID COMMENT 'Store ID',
	WH_ID COMMENT 'Warehouse ID',
	LIDLPLUS_CUST_FG COMMENT 'Lidplus customer flag',
	CY_WEEK COMMENT 'Week number',
	HARMO_CAL_WEEK_NO COMMENT 'Harmonized week no per country_2 - week since rollout',
	ADJUST_GROWTH_FG COMMENT 'Adjust growth flag - berenichte steigerung',
	WK_RF_SEGMENT_SID COMMENT 'Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_rf_segment_sid',
	WK_M_SEGMENT_SID COMMENT 'Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid',
	WK_ST_SEGMENT_SID COMMENT 'new strategic segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid',
	WK_FR_SEGMENT_SID COMMENT 'new frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid',
	WK_RE_SEGMENT_SID COMMENT 'new Recency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid',
	WK_MO_SEGMENT_SID COMMENT 'new Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid',
	CURRENCY_ISO_CD COMMENT 'ISO code for the currency of the client.',
	CURR_TOT_ID COMMENT 'Fixe Werte fur EUR=0 GBP=40 sonst Client_Id',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	PCWO_REASON_ID COMMENT 'Unique ID of the write-off or Price change reason. Country_2-specific write-off reasons have ID>100.',
	COUPON_REASON_NR COMMENT 'Identifier of the booking reason in SCRM',
	CW_WK_STR_OPEN_FG COMMENT 'Store open flag : Current week',
	CW_TOT_GROS_VAL COMMENT 'Total gross value : Current week',
	CW_TOT_NET_VAL COMMENT 'Total net value : Current week',
	CW_RCPTS_CNT COMMENT 'Receipts count : Current week',
	CW_TOT_RCPT_CNT_WK COMMENT 'Total receipts count : Current week',
	CW_TRANS_TIME_IN_MINS COMMENT 'Transaction time measured in minutes : Current week',
	CW_ITEMS_SCANNED_CNT COMMENT 'Number of items scanned : Current week',
	CW_NEW_REG_CNT COMMENT 'Null measure',
	CW_DEREG_CNT COMMENT 'Null measure',
	CW_TOT_REG_CNT COMMENT 'Null measure',
	CW_DISCOUNT_VAL COMMENT 'Discount value : Current week',
	CW_WRITEOFF_VAL COMMENT 'Writeoff net value: Current week',
	PW_WK_STR_OPEN_FG COMMENT 'Store open flag : Previous week',
	PW_TOT_GROS_VAL COMMENT 'Total gross value : Previous week',
	PW_TOT_NET_VAL COMMENT 'Total net value : Previous week',
	PW_RCPTS_CNT COMMENT 'Receipts count : Previous week',
	PW_TOT_RCPT_CNT_WK COMMENT 'Total eceipts count : Previous week',
	PW_TRANS_TIME_IN_MINS COMMENT 'Transaction time measured in minutes : Previous week',
	PW_ITEMS_SCANNED_CNT COMMENT 'Number of items scanned : Previous week',
	PW_NEW_REG_CNT COMMENT 'Null measure',
	PW_DEREG_CNT COMMENT 'Null measure',
	PW_TOT_REG_CNT COMMENT 'Null measure',
	PW_DISCOUNT_VAL COMMENT 'Discount value : Previous week',
	PW_WRITEOFF_VAL COMMENT 'Writeoff net value: Previous week',
	PYW_WK_STR_OPEN_FG COMMENT 'Store open flag : Previous year week',
	PYW_TOT_GROS_VAL COMMENT 'Total gross value : Previous year week',
	PYW_TOT_NET_VAL COMMENT 'Total net value : Previous year week week',
	PYW_RCPTS_CNT COMMENT 'Receipts count : Previous year week',
	PYW_TOT_RCPT_CNT_WK COMMENT 'Total receipts count : Previous year week',
	PYW_TRANS_TIME_IN_MINS COMMENT 'Transaction time measured in minutes : Previous year week',
	PYW_ITEMS_SCANNED_CNT COMMENT 'Number of items scanned : Previous year week',
	PYW_NEW_REG_CNT COMMENT 'Null measure',
	PYW_DEREG_CNT COMMENT 'Null measure',
	PYW_TOT_REG_CNT COMMENT 'Null measure',
	PYW_DISCOUNT_VAL COMMENT 'Discount value : Previous year week',
	PYW_WRITEOFF_VAL COMMENT 'Writeoff net value: Previous week',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) as 
SELECT
 CASE WHEN f.move_to_store_id = 0 THEN 0 ELSE f.aspect_id END AS aspect_id
,f.client_id
,f.move_to_store_id
,f.wh_id
,f.lidlplus_cust_fg
,f.cy_week
,f.harmo_cal_week_no
,f.adjust_growth_fg
,f.wk_rf_segment_sid
,f.wk_m_segment_sid
,f.wk_st_segment_sid
,f.wk_fr_segment_sid
,f.wk_re_segment_sid
,f.wk_mo_segment_sid
,f.currency_iso_cd
,f.curr_tot_id
,f.gender_cd
,f.age_range_cd
,f.pcwo_reason_id
,f.coupon_reason_nr
,f.cw_wk_str_open_fg
,f.cw_tot_gros_val
,f.cw_tot_net_val
,f.cw_rcpts_cnt
,f.cw_tot_rcpt_cnt_wk
,f.cw_trans_time_in_mins
,f.cw_items_scanned_cnt
,f.cw_new_reg_cnt
,f.cw_dereg_cnt
,f.cw_tot_reg_cnt
,f.cw_discount_val
,f.cw_writeoff_val
,f.pw_wk_str_open_fg
,f.pw_tot_gros_val
,f.pw_tot_net_val
,f.pw_rcpts_cnt
,f.pw_tot_rcpt_cnt_wk
,f.pw_trans_time_in_mins
,f.pw_items_scanned_cnt
,f.pw_new_reg_cnt
,f.pw_dereg_cnt
,f.pw_tot_reg_cnt
,f.pw_discount_val
,f.pw_writeoff_val
,f.pyw_wk_str_open_fg
,f.pyw_tot_gros_val
,f.pyw_tot_net_val
,f.pyw_rcpts_cnt
,f.pyw_tot_rcpt_cnt_wk
,f.pyw_trans_time_in_mins
,f.pyw_items_scanned_cnt
,f.pyw_new_reg_cnt
,f.pyw_dereg_cnt
,f.pyw_tot_reg_cnt
,f.pyw_discount_val
,f.pyw_writeoff_val
,f.load_id
,f.dwh_created
,f.dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.v_agg_rcpt_hdr_ldpl_wk_2 AS f
;
