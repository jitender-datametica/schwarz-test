create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_PRODUCT_VARIANT_STATUS (
	PROD_VARIANT_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'A code that defines the lifecycle status of a product variant, i.e. of a sales variant or a logistc variant.',
	PROD_VARIANT_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the status code of a product variant. (Description in group language, i.e. in German)',
	PROD_VARIANT_STATUS_DESCR_DE VARCHAR(250) COMMENT 'A textual description for the status code of a product variant. (Description in German)',
	PROD_VARIANT_STATUS_DESCR_EN VARCHAR(250) COMMENT 'A textual description for the status code of a product variant. (Description in English)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_PRODUCT_VARIANT_STATUS primary key (PROD_VARIANT_STATUS_CD)
)COMMENT='This minor dimension defines the status codes for product variants, i.e. sales variants and logistic variants.'
;