create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_LOCAL_PRODUCT_VARIANT (
	PROD_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a variant of a product.',
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LOCAL_PROD_VARIANT_NR VARCHAR(100) COMMENT 'The number which identifies the product variant within the given market / internal organization.',
	LOCAL_PROD_VARIANT_NAME VARCHAR(500) COMMENT 'The name of the product variant for the given market / internal organization.',
	PROD_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the product which is the base for this variant.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_LOCAL_PRODUCT_VARIANT primary key (INT_ORG_SID, PROD_VARIANT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A product variant may be sold under different names or is identified by different numbers, depending on the market or organization. This entity tracks the local properties of a product variant.'
;