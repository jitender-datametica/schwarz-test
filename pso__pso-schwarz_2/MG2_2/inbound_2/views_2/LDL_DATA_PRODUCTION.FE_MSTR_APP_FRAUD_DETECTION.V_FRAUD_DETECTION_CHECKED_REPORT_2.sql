create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_CHECKED_REPORT_2(
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the internal organizatio (store or sales_2 company/VGES)',
	REQUEST_TMSP COMMENT 'The point in time when this record requested by the MicroStrategy-User.',
	REPORT_ID COMMENT 'The unique identifier of MicroStrategy Report',
	CHECKED_BY_USER_NAME COMMENT 'The end user, who sets the audit flag',
	COMMENT_BY_USER COMMENT 'The comment of the user',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) as
SELECT 
main.int_org_sid AS STORE_SID
,main.request_tmsp
,main.report_id
,main.checked_by_user_name
,main.comment_by_user
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_CHECKED_REPORT_2 main;