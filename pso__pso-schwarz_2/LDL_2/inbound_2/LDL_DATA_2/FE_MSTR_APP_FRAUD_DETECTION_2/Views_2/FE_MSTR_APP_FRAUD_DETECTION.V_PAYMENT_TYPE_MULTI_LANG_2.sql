CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_PAYMENT_TYPE_MULTI_LANG_2(
	COUNTRY_ORG_SID COMMENT 'The identifier for the organization country_2',
    PAYM_TYPE_ID COMMENT 'The identifier for the way of payment, i.e. cash, card, voucher, etc.',
	LANG_CD COMMENT 'The code identifying the language.',
	PAYM_TYPE_DESCR COMMENT 'A textual description for the way of payment, i.e. cash, card, voucher, etc.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the way of payment, i.e. cash, card, voucher, etc.'
 AS SELECT 
o.int_org_sid
,main.paym_type_id
,main.lang_cd
,main.paym_type_descr
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_REL.T_PAYMENT_TYPE_2 main 
INNER JOIN CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2 o
ON main.lang_cd = o.official_lang_cd
WHERE o.is_country_org_fg
AND o.dwh_valid_fg ;