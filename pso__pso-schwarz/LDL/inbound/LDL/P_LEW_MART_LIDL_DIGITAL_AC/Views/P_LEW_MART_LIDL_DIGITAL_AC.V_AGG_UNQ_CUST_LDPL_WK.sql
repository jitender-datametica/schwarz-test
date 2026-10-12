create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_UNQ_CUST_LDPL_WK(
	ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	CLIENT_ID COMMENT 'DWH-Mandant; FK auf CLIENT',
	CY_WEEK COMMENT 'Lidl+ : Week value (-1 means data is not at month level)',
	HARMO_CAL_WEEK_NO COMMENT 'Harmonized week no per country - week since rollout',
	MOVE_TO_STORE_ID COMMENT 'Lidl Store Id',
	WH_ID COMMENT 'Warehouse ID',
	CUSTOMER_SID COMMENT 'Surrogate Key CUSTOMER',
	LIDLPLUS_CUST_FG COMMENT 'Lidl Plus Customer Flag',
	ADJUST_GROWTH_FG COMMENT 'Adjust growth flag - berenigte steigerung',
	WK_RF_SEGMENT_SID COMMENT 'Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid',
	WK_M_SEGMENT_SID COMMENT 'Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid',
	WK_ST_SEGMENT_SID COMMENT 'new strategic segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid',
	WK_FR_SEGMENT_SID COMMENT 'new frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid',
	WK_RE_SEGMENT_SID COMMENT 'new Recency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid',
	WK_MO_SEGMENT_SID COMMENT 'new Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid',
	CURRENCY_ISO_CD COMMENT 'iso code for the clients (countrys) currency',
	CURR_TOT_ID COMMENT 'Fixe Werte fur EUR=0, GBP=40 sonst Client_Id',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	CW_CUST_ACT COMMENT 'Current Week Customer Active flag 1 for active 0 for not active',
	PW_CUST_ACT COMMENT 'Previous Week Customer Active flag 1 for active 0 for not active',
	PYW_CUST_ACT COMMENT 'Previous Year Week Customer Active flag 1 for active 0 for not active',
	CW_WK_STR_OPEN_FG COMMENT 'Store open flag : Current week',
	CW_RCPTS_CNT COMMENT 'Receipts count : Current week',
	PW_WK_STR_OPEN_FG COMMENT 'Store open flag : Previous week',
	PW_RCPTS_CNT COMMENT 'Receipts count : Previous week',
	PYW_WK_STR_OPEN_FG COMMENT 'Store open flag : Previous year week',
	PYW_RCPTS_CNT COMMENT 'Receipts count : Previous year week',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT
  CASE WHEN f.move_to_store_id = 0 THEN 0 ELSE f.aspect_id END AS aspect_id
,f.client_id
,f.cy_week
,f.harmo_cal_week_no
,f.move_to_store_id
,f.wh_id
,f.customer_sid
,f.lidlplus_cust_fg
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
,f.cw_cust_act
,f.pw_cust_act
,f.pyw_cust_act
,f.cw_wk_str_open_fg
,f.cw_rcpts_cnt
,f.pw_wk_str_open_fg
,f.pw_rcpts_cnt
,f.pyw_wk_str_open_fg
,f.pyw_rcpts_cnt
,f.load_id
,f.dwh_created
,f.dwh_updated
FROM p_lew_mart_lidl_digital.v_agg_unq_cust_ldpl_wk AS f
;
