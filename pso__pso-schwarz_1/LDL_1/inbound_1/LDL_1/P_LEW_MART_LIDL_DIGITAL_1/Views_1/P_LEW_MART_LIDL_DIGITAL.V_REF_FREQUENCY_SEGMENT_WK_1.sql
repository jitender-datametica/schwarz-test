create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.V_REF_FREQUENCY_SEGMENT_WK_1(
	WK_FR_SEGMENT_SID COMMENT 'Ids of new FREQUENCY segments from rfm model - used (WK_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid',
	WK_FR_SEGMENT_NAME COMMENT 'new FREQUENCY segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special',
	WK_FR_SEGMENT_DESCR COMMENT 'Exact description of new FREQUENCY from rfm model',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidlplus : new FREQUENCY segments - referenece table'
 as
SELECT
 WK_FR_SEGMENT_SID
,WK_FR_SEGMENT_NAME
,WK_FR_SEGMENT_DESCR
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.T_REF_FREQUENCY_SEGMENT_WK_1 
;
