create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_FACT_WAWI_ITEM_VARIANT_SALES_PRICE_1 (
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	INT_ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_1 organization.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
	WAWI_ITEM_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item_1 variant.',
	WAWI_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SALES_NET_PRICE NUMBER(38,5) NOT NULL COMMENT 'The net price (i.e. excluding VAT) for which products that are related to the Wawi item_1 variant are sold in the given store or warehouse.',
	SALES_GROSS_PRICE NUMBER(38,5) NOT NULL COMMENT 'The gross price (i.e. including VAT) for which products that are related to the Wawi item_1 variant are sold in the given store or warehouse.',
	DEPOSIT_VAL NUMBER(38,5) COMMENT 'The deposit amount for this Wawi item_1 variant. E.g. 25c for a plastic bottle. (This attribute is only filled, if there is a deposit.)',
	TAX_PCT NUMBER(38,5) NOT NULL COMMENT 'The actual tax percentage which is applicable for the Wawi item_1 variant in the given store or warehouse. (In case several taxes apply, this is the total tax percentage.)',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FACT_WAWI_ITEM_VARIANT_SALES_PRICE primary key (INT_ORG_SID, WAWI_ITEM_VARIANT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A derived table tracking the sales_1 prices of Wawi item_1 variants in stores and warehouses. (For reasons of data volume this table does not contain one record per day, but is historized.)'
;