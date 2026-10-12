create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_FACT_EXCHANGE_RATE_2 (
	SRC_CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code according to ISO-4217, identifying the currency that is to be converted.',
	TGT_CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code according to ISO-4217, identifying the currency into which the source currency is to be converted.',
	EXCHANGE_RATE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way in which one currency can be converted into another.',
	ACTIVE_FROM_DT DATE NOT NULL COMMENT 'The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).',
	ACTIVE_TO_DT DATE NOT NULL COMMENT 'The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).',
	ACTIVE_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt.',
	BUS_YEAR NUMBER(38,0) NOT NULL COMMENT 'Some exchange rates are considered valid for an entire business year. If this is the case, this is the business year.',
	EXCHANGE_RATE NUMBER(38,6) NOT NULL COMMENT 'The factor by which the amount in the source currency (from_curr_cd) needs to be multiplied, so that the result is in the target currency (to_curr_cd).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FACT_EXCHANGE_RATE primary key (SRC_CURR_CD, TGT_CURR_CD, EXCHANGE_RATE_TYPE_CD, ACTIVE_FROM_DT)
)COMMENT='Currency exchange rates. For a given pair of currencies there might be several exchange rate types. Some of them might be valid for an entire business year.'
;