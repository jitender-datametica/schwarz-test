create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION cluster by (BUS_DT)(
	CASH_REGISTER_EVENT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.',
	CASH_REGISTER_EVENT_NR VARCHAR(20) NOT NULL COMMENT 'The sequence number of the cash register transaction. It is unique to the cash register, but might be re-cycled after some time.',
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.)',
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related cash register event happened.',
	BUS_DT DATE NOT NULL COMMENT 'The business date on which the retail event is counted.',
	CASHIER_NR VARCHAR(20) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
	CASH_REGISTER_EVENT_CNT NUMBER(38,0) NOT NULL COMMENT 'This column shows how much cash register events are relevant (default value is 1)',
	CASH_REGISTER_EVENT_AFFECTED_LINE_CNT NUMBER(38,0) COMMENT 'Count of the cash register event lines for a particular scenario ',
	CASH_REGISTER_EVENT_AFFECTED_NET_VAL NUMBER(38,5) COMMENT 'Sum of the cash register event lines for a particular scenario ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	CUST_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer.If not customer exist then -1 is the default value.',
	CUST_IDENT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.',
	EVENT_END_HR NUMBER(38,0) NOT NULL COMMENT 'Holds the hour from \""Event end tmsp\"", so for example if the receipt close at \""13:34:56\"", the value in the column will be \""13\"".',
	CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL NUMBER(38,5) COMMENT 'Sum(gross) of the cash register event lines for a particular scenario ',
	constraint PK_T_CASH_REGISTER_EVENT_CLASSIFICATION primary key (CASH_REGISTER_EVENT_SID, SCENARIO_ID)
)COMMENT='This table lists link cash register event to all fraud scenarious which applies to this event'
;