create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_MSTR_REPORT(
	REPORT_ID COMMENT 'The unique identifier of MicroStrategy Report',
	REPORT_GRP_ID COMMENT 'The unique identifier of fraud detection scenario group.',
	REPORT_NAME COMMENT 'The name of the report which will be used by the navigation.',
	REPORT_DESCR COMMENT 'Describes the report.',
	REPORT_TYPE_CD COMMENT 'Type of report, code which defines if it is developed for manual or automatic for different layers',
	REPORT_OFFSET COMMENT 'The sequence number of the report, in which order it will be displayed',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Keeps the fraud detection metrics for MicroStrategy Dynamic Dashboards '
 as SELECT
main.report_id
,main.report_grp_id
,main.report_name
,main.report_descr
,main.report_type_cd
,main.report_offset
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_REPORT main;