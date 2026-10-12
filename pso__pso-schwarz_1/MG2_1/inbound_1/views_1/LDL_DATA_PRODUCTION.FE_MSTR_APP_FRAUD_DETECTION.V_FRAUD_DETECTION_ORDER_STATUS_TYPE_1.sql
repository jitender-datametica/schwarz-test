create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_ORDER_STATUS_TYPE_1(
	ORDER_PARAMETER_STATUS_CD COMMENT 'The status_1 of a order parameter if it is approved, requested or denied.',
	ORDER_PARAMETER_STATUS_SEQ COMMENT 'Display order in frontend drop-down',
	ORDER_PARAMETER_STATUS_DESCR COMMENT 'Textual describes of the lifecycle status_1',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This look-up table defines the status_1 of the revision order'
 as SELECT 
main.order_parameter_status_cd
,main.order_parameter_status_seq
,main.order_parameter_status_descr
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER_STATUS_TYPE_1 main;