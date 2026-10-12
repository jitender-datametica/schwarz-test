create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_VARIANT_SALES_PRICE (
	PROD_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a sales variant of a product.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SALES_GROSS_PRICE NUMBER(38,5) NOT NULL COMMENT 'The gross price for which this product variant is sold in the store.',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	PRICE_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'the unique identifier (surrogate key) for the price level of a product.',
	PRICE_REASON_CD VARCHAR(20) COMMENT 'the code identifying the reason why a price was defined for a product. e.g. permanent price change, promotional price, etc.',
	constraint PK_T_PRODUCT_VARIANT_SALES_PRICE primary key (PROD_VARIANT_SID, PRICE_GRP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the sales price of a product, depending on the price level.'
;