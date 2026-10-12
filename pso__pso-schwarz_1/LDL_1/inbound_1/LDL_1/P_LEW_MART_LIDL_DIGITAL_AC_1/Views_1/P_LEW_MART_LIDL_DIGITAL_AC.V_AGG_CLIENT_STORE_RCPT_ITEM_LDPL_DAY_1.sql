create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_CLIENT_STORE_RCPT_ITEM_LDPL_DAY_1(
	ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	CLIENT_ID COMMENT 'Identifier for client',
	GEO_AREA_SID COMMENT 'Ceographical identifier for client',
	DWH_CAL_DT COMMENT 'Data date',
	CY_MONTH COMMENT 'Calendar_1 Year+Month in form YYYYMM',
	CY_MONTH_PREV_1M COMMENT 'The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]',
	CY_MONTH_PREV_1Y COMMENT 'The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]',
	CY_WEEK COMMENT 'The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.    [Week Identifier]',
	CY_WEEK_PREV_1W COMMENT 'The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]',
	CY_WEEK_PREV_1Y COMMENT 'The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]',
	BUSYEAR_QTR COMMENT 'Business year quarter identifier',
	WK_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	WK_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	WK_ST_SEGMENT_SID COMMENT 'ids of strategic segments from rfm model',
	WK_FR_SEGMENT_SID COMMENT 'ids of frequency segments from rfm model',
	WK_RE_SEGMENT_SID COMMENT 'ids of recency segments from rfm model',
	WK_MO_SEGMENT_SID COMMENT 'ids of new monetary segments from rfm model',
	MTH_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	MTH_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	MTH_ST_SEGMENT_SID COMMENT 'ids of strategic segments from rfm model',
	MTH_FR_SEGMENT_SID COMMENT 'ids of frequency segments from rfm model',
	MTH_RE_SEGMENT_SID COMMENT 'ids of recency segments from rfm model',
	MTH_MO_SEGMENT_SID COMMENT 'ids of new monetary segments from rfm model',
	BUSYEAR_QTR_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	BUSYEAR_QTR_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	LOC_SID COMMENT 'Store ID',
	MOVE_TO_STORE_ID COMMENT 'Store ID after last store relocation',
	WH_ID COMMENT 'Warehouse ID',
	ITEM_SID COMMENT 'Item_1 surrogate ID (uniquely across all countries/clients)',
	LIDLPLUS_CUST_FG COMMENT 'Lidplus customer flag',
	EAN_BARCODE COMMENT 'EAN_1 Barcode',
	CUSTOMER_SID COMMENT 'Surrogate Key CUSTOMER',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	RECEIPT_ID COMMENT 'Identifier for receipt',
	REGISTER_ID COMMENT 'Identifier of a cashier',
	RECEIPT_CNT COMMENT 'Unique Receipt combination used for count distinct in Microstrategy ',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) as SELECT 
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
 ,f.move_to_store_id
 ,f.wh_id           
 ,f.item_sid        
 ,f.lidlplus_cust_fg
 ,f.ean_barcode     
 ,f.customer_sid 
 ,f.gender_cd
 ,f.age_range_cd
 ,f.household_type_id
 ,f.child_age_range_group_id
 ,f.receipt_id      
 ,f.register_id     
 ,f.receipt_cnt_uniq
 ,f.load_id         
 ,f.dwh_created 
 ,f.dwh_updated     
FROM p_lew_mart_lidl_digital.v_agg_client_store_rcpt_item_ldpl_day_1 AS f;
