create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_REF_MONETARY_SEGMENT_WK_1(
	WK_MO_SEGMENT_SID COMMENT 'ids of new monetary segments from rfm model',
	WK_MO_SEGMENT_NAME COMMENT 'new monetary segments, m_segment: high, medium, low',
	WK_MO_SEGMENT_DESCR COMMENT 'exact description of new monetary segments from rfm model',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidlplus : new monetary segments - referenece table'
 as
SELECT
 WK_MO_SEGMENT_SID
,WK_MO_SEGMENT_NAME
,WK_MO_SEGMENT_DESCR
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_MONETARY_SEGMENT_WK_1 
;
