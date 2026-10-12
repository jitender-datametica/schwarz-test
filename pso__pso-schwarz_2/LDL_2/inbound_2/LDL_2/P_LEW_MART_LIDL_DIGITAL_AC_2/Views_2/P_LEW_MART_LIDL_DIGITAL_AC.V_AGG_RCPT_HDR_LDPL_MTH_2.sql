create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_RCPT_HDR_LDPL_MTH_2(
	ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	CLIENT_ID COMMENT 'Identifier for client',
	MOVE_TO_STORE_ID COMMENT 'Store ID',
	WH_ID COMMENT 'Warehouse ID',
	LIDLPLUS_CUST_FG COMMENT 'Lidplus customer flag',
	ADJUST_GROWTH_FG COMMENT 'Adjust growth flag - berenigte steigerung',
	MTH_RF_SEGMENT_SID COMMENT 'Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid',
	MTH_M_SEGMENT_SID COMMENT 'Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	MTH_ST_SEGMENT_SID COMMENT 'new strategy Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	MTH_FR_SEGMENT_SID COMMENT 'new frequency Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	MTH_RE_SEGMENT_SID COMMENT 'new Recency Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	MTH_MO_SEGMENT_SID COMMENT 'new Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	BUSYEAR_QTR_RF_SEGMENT_SID COMMENT 'Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_busyear_qtr.busyear_qtr_rf_segment_sid',
	BUSYEAR_QTR_M_SEGMENT_SID COMMENT 'Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_busyear_qtr.busyear_m_segment_sid',
	CY_MONTH COMMENT 'Month number',
	HARMO_CAL_MONTH_NO COMMENT 'Harmonized month no  per country_2 - month since rollout',
	CURRENCY_ISO_CD COMMENT 'ISO code for the currency of the client.',
	CURR_TOT_ID COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	PCWO_REASON_ID COMMENT 'Unique ID of the write-off or Price change reason. Country_2-specific write-off reasons have ID>100.',
	COUPON_REASON_NR COMMENT 'Identifier of the booking reason in SCRM',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	CM_MTH_STR_OPEN_FG COMMENT 'Store open flag : Current month',
	CM_TOT_GROS_VAL COMMENT 'Total gross value : Current month',
	CM_TOT_NET_VAL COMMENT 'Total net value : Current month',
	CM_RCPTS_CNT COMMENT 'Receipts count : Current month',
	CM_TOT_RCPT_CNT_MTH COMMENT 'Receipts count',
	CM_TRANS_TIME_IN_MINS COMMENT 'Transaction time measured in minutes : Current month',
	CM_ITEMS_SCANNED_CNT COMMENT 'Number of items scanned : Current month',
	CM_NEW_REG_CNT COMMENT 'Number of new registrations for given month',
	CM_DEREG_CNT COMMENT 'Number of deregistrations for given month',
	CM_TOT_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to given month',
	CM_DISCOUNT_VAL COMMENT 'Discount value : Current month',
	CM_WRITEOFF_VAL COMMENT 'Writeoff net value: Current month',
	PM_MTH_STR_OPEN_FG COMMENT 'Store open flag : Previous month',
	PM_TOT_GROS_VAL COMMENT 'Total gross value : Previous month',
	PM_TOT_NET_VAL COMMENT 'Total net value : Previous month',
	PM_RCPTS_CNT COMMENT 'Receipts count : Previous month',
	PM_TOT_RCPT_CNT_MTH COMMENT 'Receipts count',
	PM_TRANS_TIME_IN_MINS COMMENT 'Transaction time measured in minutes : Previous month',
	PM_ITEMS_SCANNED_CNT COMMENT 'Number of items scanned : Previous month',
	PM_NEW_REG_CNT COMMENT 'Number of new registrations for previous month',
	PM_DEREG_CNT COMMENT 'Number of deregistrations for previous month',
	PM_TOT_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to previous month',
	PM_DISCOUNT_VAL COMMENT 'Discount value : Previous month',
	PM_WRITEOFF_VAL COMMENT 'Writeoff net value: Previous month',
	PYM_MTH_STR_OPEN_FG COMMENT 'Store open flag : Previous year month',
	PYM_TOT_GROS_VAL COMMENT 'Total gross value : Previous year month',
	PYM_TOT_NET_VAL COMMENT 'Total net value : Previous year month',
	PYM_RCPTS_CNT COMMENT 'Receipts count : Previous year month',
	PYM_TOT_RCPT_CNT_MTH COMMENT 'Receipts count',
	PYM_TRANS_TIME_IN_MINS COMMENT 'Transaction time measured in minutes : Previous year month',
	PYM_ITEMS_SCANNED_CNT COMMENT 'Number of items scanned : Previous year month',
	PYM_NEW_REG_CNT COMMENT 'Number of new registrations for previous year month',
	PYM_DEREG_CNT COMMENT 'Number of deregistrations for previous year month',
	PYM_TOT_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to previous year month',
	PYM_DISCOUNT_VAL COMMENT 'Discount value : Previous year month',
	PYM_WRITEOFF_VAL COMMENT 'Writeoff net value: Previous year month',
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
,f.adjust_growth_fg
,f.mth_rf_segment_sid
,f.mth_m_segment_sid
,f.mth_st_segment_sid
,f.mth_fr_segment_sid
,f.mth_re_segment_sid
,f.mth_mo_segment_sid
,f.busyear_qtr_rf_segment_sid
,f.busyear_qtr_m_segment_sid
,f.cy_month
,f.harmo_cal_month_no
,f.currency_iso_cd
,f.curr_tot_id
,f.gender_cd
,f.age_range_cd
,f.pcwo_reason_id
,f.coupon_reason_nr 
,f.household_type_id
,f.child_age_range_group_id
,f.cm_mth_str_open_fg
,f.cm_tot_gros_val
,f.cm_tot_net_val
,f.cm_rcpts_cnt
,f.cm_tot_rcpt_cnt_mth
,f.cm_trans_time_in_mins
,f.cm_items_scanned_cnt
,f.cm_new_reg_cnt
,f.cm_dereg_cnt
,f.cm_tot_reg_cnt
,f.cm_discount_val
,f.cm_writeoff_val
,f.pm_mth_str_open_fg
,f.pm_tot_gros_val
,f.pm_tot_net_val
,f.pm_rcpts_cnt
,f.pm_tot_rcpt_cnt_mth
,f.pm_trans_time_in_mins
,f.pm_items_scanned_cnt
,f.pm_new_reg_cnt
,f.pm_dereg_cnt
,f.pm_tot_reg_cnt
,f.pm_discount_val
,f.pm_writeoff_val
,f.pym_mth_str_open_fg
,f.pym_tot_gros_val
,f.pym_tot_net_val
,f.pym_rcpts_cnt
,f.pym_tot_rcpt_cnt_mth
,f.pym_trans_time_in_mins
,f.pym_items_scanned_cnt
,f.pym_new_reg_cnt
,f.pym_dereg_cnt
,f.pym_tot_reg_cnt
,f.pym_discount_val
,f.pym_writeoff_val
,f.load_id
,f.dwh_created
,f.dwh_updated
FROM p_lew_mart_lidl_digital.v_agg_rcpt_hdr_ldpl_mth_2 AS f
;
