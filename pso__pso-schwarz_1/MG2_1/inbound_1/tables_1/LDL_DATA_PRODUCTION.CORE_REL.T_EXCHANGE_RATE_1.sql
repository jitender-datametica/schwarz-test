create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_EXCHANGE_RATE_1 (
	SRC_CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217, that is to be converted into the target currency.',
	TGT_CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217, into which the source currency is converted.',
	EXCHANGE_RATE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	EXCHANGE_RATE NUMBER(38,5) NOT NULL COMMENT 'The factor by which the amount in the source currency needs to be multiplied, so that the result is in the target currency.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_EXCHANGE_RATE primary key (EXCHANGE_RATE_TYPE_CD, TGT_CURR_CD, SRC_CURR_CD, DWH_VALID_FROM_TMSP)
)COMMENT='An exchange rate defines the way, how an amount in one currency can be converted into another currency. Exchange rates change frequently. Typically, there are several exchange rates for a given pair of currencies, such as a rate that his offered by a specific financial institution or the daily reference rate of the ECB.'
;