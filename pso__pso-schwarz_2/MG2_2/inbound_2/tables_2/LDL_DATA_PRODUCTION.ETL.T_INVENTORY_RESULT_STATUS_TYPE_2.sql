create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_INVENTORY_RESULT_STATUS_TYPE_2 (
	INV_RESULT_STATUS_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the counting status_2 of an inventory result. It shows, if the product could be counted.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	INV_RESULT_STATUS_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the counting status_2 of an inventory result. It shows, if the product could be counted.'
)COMMENT='This minor entity defines the counting status_2 of an inventory result. It shows, if the product could be counted.'
;