create or replace TABLE LDL_DATA_PRODUCTION.EVAL.T_CANCELLATION_LINE_20250319121445 cluster by (
     COUNTRY_ORG_CD,
     BUS_DT
)(
	RETAIL_EVENT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales or return of products..',
	RETAIL_EVENT_LINE_SEQ NUMBER(38,0) NOT NULL COMMENT 'The number of the line in the retail event.',
	EVENT_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the cancellation happened.',
	BUS_DT DATE NOT NULL COMMENT 'The business date on which the retail event is counted.',
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country organization.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	CASH_REGISTER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the cash register which has created this transaction.',
	CASH_REGISTER_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)',
	CASH_REGISTER_USG_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.',
	CASHIER_HASH VARCHAR(32) NOT NULL COMMENT 'The encrypted number of the cashier. (The hash is unique for a given store and a day.)',
	AUTH_BY_HASH VARCHAR(32) COMMENT 'In case of a cancellation or any other non-standard operation, the transaction must be authorized by the store manager or by another employee. This is the encrypted number which identifies the employee, who has authorized the transaction. (The hash is unique for a given store and a day.)',
	CUST_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the customer.',
	RETAIL_EVENT_LINE_SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The numeric identifier for the scenario which is represented by the retail event line.',
	INPUT_CANCEL_NR VARCHAR(100) COMMENT 'A number typed in or scanned by the cashier.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CANCELLATION_LINE primary key (RETAIL_EVENT_SID, RETAIL_EVENT_LINE_SEQ)
)COMMENT='The event of cancelling an erroneus or unwanted product retail line.'
;