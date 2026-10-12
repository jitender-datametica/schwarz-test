create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_VARIANT_INPUT_NUMBER_TYPE (
	PROD_VARIANT_INPUT_NR_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN, a GTIN or a product lookup number (PLU).',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_VARIANT_INPUT_NR_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN, a GTIN or a product lookup number (PLU).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_VARIANT_INPUT_NUMBER_TYPE primary key (PROD_VARIANT_INPUT_NR_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN, a GTIN or a product lookup number (PLU).'
;