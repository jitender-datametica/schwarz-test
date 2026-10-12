CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_ANALYSIS_STATUS_TYPE_1(
	FRAUD_ANALYSIS_STATUS_CD COMMENT 'Indicator showing it user has manually clasified this transaction, if it suspicious or not. First status_1 comes: SP-suspicious and then maybe later on NSP- not suspicious',
	FRAUD_ANALYSIS_STATUS_CD_DESCR COMMENT 'Textual description for the marked code',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT ='Lookup for the Indicator showing it user has manually classified this transaction'
AS SELECT 
main.fraud_analysis_status_cd
,main.fraud_analysis_status_cd_descr
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd 
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_ANALYSIS_STATUS_TYPE_1 main;