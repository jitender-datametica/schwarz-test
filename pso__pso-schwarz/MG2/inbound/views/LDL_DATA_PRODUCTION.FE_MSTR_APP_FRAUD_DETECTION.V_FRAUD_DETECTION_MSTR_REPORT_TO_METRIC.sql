create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_MSTR_REPORT_TO_METRIC(
	REPORT_ID COMMENT 'The unique identifier of MicroStrategy Report',
	METRIC_ID COMMENT 'The unique identifier of microstratey metric',
	METRIC_OFFSET COMMENT 'The display order of the metric on the report',
	METRIC_NAME COMMENT 'The Name of the metric',
	FORMAT_TYPE_CD COMMENT 'Type of format, code which defines metric format like integer, percent, currency',
	CALCULATION_TYPE_CD COMMENT 'Type of calculation, code which defines type of calculation like SUM, weighted Average, count',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) as
SELECT
main.report_id
,main.metric_id
,main.metric_offset
,met.metric_name
,met.format_type_cd
,met.calculation_type_cd
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_REPORT_TO_METRIC main
INNER JOIN CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_METRIC met
ON main.metric_id = met.metric_id;