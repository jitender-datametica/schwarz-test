create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_INVENTORY_PRODUCT_REASON_2 (
	INV_PROD_REASON_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the reason why an inventory was initiated for a certain product.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	INV_PROD_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the reason why an inventory was initiated for a certain product.'
)COMMENT='This minor entity defines the reason why an inventory was initiated for a certain product.'
;