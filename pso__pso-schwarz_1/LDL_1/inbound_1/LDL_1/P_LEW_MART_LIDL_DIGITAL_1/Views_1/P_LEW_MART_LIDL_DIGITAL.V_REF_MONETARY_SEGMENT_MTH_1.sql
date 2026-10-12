create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.V_REF_MONETARY_SEGMENT_MTH_1(
	MTH_MO_SEGMENT_SID COMMENT 'Ids of new MONETARY segments from rfm model - used (MTH_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid',
	MTH_MO_SEGMENT_NAME COMMENT 'new MONETARY segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special',
	MTH_MO_SEGMENT_DESCR COMMENT 'Exact description of new MONETARY from rfm model',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidlplus : new MONETARY segments - referenece table'
 as
SELECT
 MTH_MO_SEGMENT_SID
,MTH_MO_SEGMENT_NAME
,MTH_MO_SEGMENT_DESCR
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.T_REF_MONETARY_SEGMENT_MTH_1 
;
