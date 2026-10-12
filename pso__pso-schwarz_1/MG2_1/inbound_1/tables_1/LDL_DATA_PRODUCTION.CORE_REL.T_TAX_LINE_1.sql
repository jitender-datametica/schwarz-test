create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_TAX_LINE_1 cluster by (
     COUNTRY_ORG_CD,
     BUS_DT
)(
	RETAIL_EVENT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..',
	RETAIL_EVENT_LINE_SEQ NUMBER(38,0) NOT NULL COMMENT 'The number of the line in the retail event.',
	EVENT_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the tax calculation happened.',
	BUS_DT DATE NOT NULL COMMENT 'The business date on which the retail event is counted.',
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country.)',
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	CASH_REGISTER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the cash register which has created this transaction.',
	CASH_REGISTER_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)',
	CASH_REGISTER_USG_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.',
	CASHIER_HASH VARCHAR(32) NOT NULL COMMENT 'The encrypted number of the cashier. (The hash is unique for a given store and a day.)',
	CUST_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the customer.',
	TAX_CLASS_CD VARCHAR(20) NOT NULL COMMENT 'The code for the tax class, e.g. Reduced VAT Rate.',
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the geographical area to which the tax class applies.',
	TAX_PCT NUMBER(38,5) NOT NULL COMMENT 'The actual tax percentage which is valid for the given tax class. E.g. 19%',
	GROSS_VAL NUMBER(38,5) NOT NULL COMMENT 'The gross amount for which VAT is calculated.',
	TAX_VAL NUMBER(38,5) NOT NULL COMMENT 'The resulting tax value.',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_TAX_LINE primary key (RETAIL_EVENT_SID, RETAIL_EVENT_LINE_SEQ)
)COMMENT='The VATsummary for a retail event. There is one tax line for each VAT class.'
;