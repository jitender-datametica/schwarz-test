create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_UNQ_CUST_LDPL_MTH_1(
	ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	CLIENT_ID COMMENT 'DWH-Mandant_1; FK auf CLIENT',
	CY_MONTH COMMENT 'Lidl+ : Month value (-1 means data is not at month level)',
	HARMO_CAL_MONTH_NO COMMENT 'Harmonized month no  per country_1 - month since rollout',
	MOVE_TO_STORE_ID COMMENT 'Lidl Store Id',
	WH_ID COMMENT 'Warehouse ID',
	CUSTOMER_SID COMMENT 'Surrogate Key CUSTOMER',
	LIDLPLUS_CUST_FG COMMENT 'Lidl Plus Customer Flag',
	ADJUST_GROWTH_FG COMMENT 'Adjust growth flag - berenigte steigerung',
	MTH_RF_SEGMENT_SID COMMENT 'Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid',
	MTH_M_SEGMENT_SID COMMENT 'Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	MTH_ST_SEGMENT_SID COMMENT 'new strategic Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	MTH_FR_SEGMENT_SID COMMENT 'new frequency Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	MTH_RE_SEGMENT_SID COMMENT 'new Recency Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	MTH_MO_SEGMENT_SID COMMENT 'new Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid',
	BUSYEAR_QTR_RF_SEGMENT_SID COMMENT 'Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_busyear_qtr.busyear_qtr_rf_segment_sid',
	BUSYEAR_QTR_M_SEGMENT_SID COMMENT 'Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_busyear_qtr.busyear_m_segment_sid',
	CURRENCY_ISO_CD COMMENT 'iso code for the clients (countrys) currency',
	CURR_TOT_ID COMMENT 'Fixe Werte fur EUR=0, GBP=40 sonst Client_Id',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	CM_CUST_ACT COMMENT 'Current Month Customer Active flag 1 for active 0 for not active',
	PM_CUST_ACT COMMENT 'Previous Month Customer Active flag 1 for active 0 for not active',
	PYM_CUST_ACT COMMENT 'Previous Year Month Customer Active flag 1 for active 0 for not active',
	CM_MTH_STR_OPEN_FG COMMENT 'Store open flag : Current month',
	CM_RCPTS_CNT COMMENT 'Receipts count : Current month',
	PM_MTH_STR_OPEN_FG COMMENT 'Store open flag : Previous month',
	PM_RCPTS_CNT COMMENT 'Receipts count : Previous month',
	PYM_MTH_STR_OPEN_FG COMMENT 'Store open flag : Previous year month',
	PYM_RCPTS_CNT COMMENT 'Receipts count : Previous year month',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT
 CASE WHEN f.move_to_store_id = 0 THEN 0 ELSE f.aspect_id END AS aspect_id
,f.client_id
,f.cy_month
,f.harmo_cal_month_no
,f.move_to_store_id
,f.wh_id
,f.customer_sid
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
,f.currency_iso_cd
,f.curr_tot_id
,f.gender_cd
,f.age_range_cd 
,f.household_type_id
,f.child_age_range_group_id
,f.cm_cust_act
,f.pm_cust_act
,f.pym_cust_act
,f.cm_mth_str_open_fg
,f.cm_rcpts_cnt
,f.pm_mth_str_open_fg
,f.pm_rcpts_cnt
,f.pym_mth_str_open_fg
,f.pym_rcpts_cnt
,f.load_id
,f.dwh_created
,f.dwh_updated
FROM p_lew_mart_lidl_digital.v_agg_unq_cust_ldpl_mth_1 AS f
;
