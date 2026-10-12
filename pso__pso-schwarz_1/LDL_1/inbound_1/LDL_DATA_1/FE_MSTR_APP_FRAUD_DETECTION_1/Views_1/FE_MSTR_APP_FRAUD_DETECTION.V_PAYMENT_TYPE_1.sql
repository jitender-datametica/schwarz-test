CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_PAYMENT_TYPE_1(
	PAYM_TYPE_ID COMMENT 'The identifier for the way of payment, i.e. cash, card, voucher, etc.',
	LANG_CD COMMENT 'The code identifying the language.',
	PAYM_TYPE_DESCR COMMENT 'A textual description for the way of payment, i.e. cash, card, voucher, etc.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the way of payment, i.e. cash, card, voucher, etc.'
 AS SELECT 
main.paym_type_id
,main.lang_cd
,main.paym_type_descr
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_REL.T_PAYMENT_TYPE_1 main
WHERE main.lang_cd = 'DE';