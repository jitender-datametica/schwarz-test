create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_REF_STRATEGIC_SEGMENT_GROUP_WK(
	WK_ST_SEGMENT_GROUP_SID COMMENT 'ids of STRATEGIC segments group',
	WK_ST_SEGMENT_GROUP_NAME COMMENT 'STRATEGIC segments group',
	WK_ST_SEGMENT_GROUP_ACTIVE_FG COMMENT 'Description for segment activation, 0 - inactive, 1 - active',
	WK_ST_SEGMENT_GROUP_ACTIVE_FG_NAME COMMENT 'Description for Segment Activation',
	WK_ST_SEGMENT_SID COMMENT 'ids of STRATEGIC segments from rfm model',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidlplus : STRATEGIC segments group - reference table'
 as
SELECT
 wk_st_segment_group_sid
,wk_st_segment_group_name
,wk_st_segment_group_active_fg  
,wk_st_segment_group_active_fg_name 
,wk_st_segment_sid
,load_id
,dwh_created
,dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_STRATEGIC_SEGMENT_GROUP_WK 
;
