CREATE TABLE CORE.T_FACT_CURRENCY_EXCHANGE_RATE_2 (
	FROM_CURR_CD VARCHAR(5) NOT NULL COMMENT 'The code identifying the source currency according to ISO-4217.',
	TO_CURR_CD VARCHAR(5) NOT NULL COMMENT 'The code identifying the target currency according to ISO-4217.',
	CURR_EXCHANGE_RATE_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'The code identifying the way in which one currency can be converted into another.',
	ACTIVE_FROM_DT DATE NOT NULL COMMENT 'The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).',
	ACTIVE_TO_DT DATE COMMENT 'The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).',
	ACTIVE_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt.',
	EXCHANGE_RATE NUMBER(9,5) COMMENT 'The factor by which the amount in the source currency (from_curr_cd) needs to be multiplied, so that the result is in the target currency (to_curr_cd).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source tables',
	CONSTRAINT PK_T_FACT_CURRENCY_EXCHANGE_RA PRIMARY KEY (FROM_CURR_CD, TO_CURR_CD, CURR_EXCHANGE_RATE_TYPE_CD, ACTIVE_FROM_DT)
)COMMENT='Currency exchange rates. For a given pair of currencies there might be several exchange rate types. Some of them might be valid for an entire business year.'
;