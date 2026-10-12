CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_VALUE_1(
	PARAM_ID COMMENT 'The unique identifier of parameter (thereshold) of a scenario',
	COUNTRY_ORG_SID COMMENT 'The unique identifier of the related business country. (The business country_1 is not identical to a political country_1',
	COUNTRY_ORG_CD COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country_1',
	PARAM_STATUS_CD COMMENT 'The status_1 of a parameter value if it is approved, requested or denied.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PARAM_VAL_QTY COMMENT 'The value of scenario parameter, which is provided by end user.',
	REQUESTOR_USER_NAME COMMENT 'The MSTR-User who enters the value to the system',
	REQUEST_TMSP COMMENT 'The point of the time, when the entry is done.',
	APPROVER_USER_NAME COMMENT 'The MSTR-User who approves the value entered to the system',
	APPROVED_TMSP COMMENT 'The point of the time when the entry is approved.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A parameter can have a value which then impact the scenario result'
 AS
SELECT 
main.param_id AS param_id
,org.country_org_sid AS country_org_sid
,main.country_org_cd AS country_org_cd
,main.param_status_cd AS param_status_cd
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.param_val_qty AS param_val_qty
,main.requestor_user_name AS requestor_user_name
,main.request_tmsp AS request_tmsp
,main.approver_user_name AS approver_user_name
,main.approved_tmsp AS approved_tmsp
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_PARAMETER_VALUE_1 main
INNER JOIN CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1 org
ON main.country_org_cd = org.country_org_cd
AND org.is_country_org_fg
AND org.dwh_valid_fg;