create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.V_REF_RECENCY_SEGMENT_WK(
	WK_RE_SEGMENT_SID COMMENT 'Ids of new RECENCY segments from rfm model - used (WK_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid',
	WK_RE_SEGMENT_NAME COMMENT 'new RECENCY segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special',
	WK_RE_SEGMENT_DESCR COMMENT 'Exact description of new RECENCY from rfm model',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidlplus : new RECENCY segments - referenece table'
 as
SELECT
 WK_RE_SEGMENT_SID
,WK_RE_SEGMENT_NAME
,WK_RE_SEGMENT_DESCR
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.T_REF_RECENCY_SEGMENT_WK 
;
