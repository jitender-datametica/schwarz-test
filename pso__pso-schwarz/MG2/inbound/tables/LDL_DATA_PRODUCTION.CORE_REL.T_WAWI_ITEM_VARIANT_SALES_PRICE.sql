create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM_VARIANT_SALES_PRICE (
	WAWI_ITEM_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item variant.',
	PRICE_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the price level of a product.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SALES_GROSS_PRICE NUMBER(38,5) NOT NULL COMMENT 'The official gross price for which the sales variants which are contained in the given Wawi item variant, are sold.',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
	PRICE_REASON_CD VARCHAR(20) COMMENT 'The code identifying the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_WAWI_ITEM_VARIANT_SALES_PRICE primary key (WAWI_ITEM_VARIANT_SID, PRICE_GRP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the sales price of a Wawi product variant, depending on the price level. (Note that the Wawi item variant is not the product which is actually sold!)'
;