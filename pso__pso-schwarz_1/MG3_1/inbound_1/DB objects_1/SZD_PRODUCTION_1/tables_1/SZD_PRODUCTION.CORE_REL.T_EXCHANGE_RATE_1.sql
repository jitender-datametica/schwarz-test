create or replace TABLE SZD_PRODUCTION.CORE_REL.T_EXCHANGE_RATE_1 (
	SOURCE_CURRENCY_CD VARCHAR(50) NOT NULL COMMENT 'Natural/Business Key - The code identifying the currency, according to ISO 4217.',
	TARGET_CURRENCY_CD VARCHAR(50) NOT NULL COMMENT 'Natural/Business Key - The code identifying the currency, according to ISO 4217.',
	EXCHANGE_RATE_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Natural/Business Key - The code identifying the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	EXCHANGE_RATE NUMBER(38,5) NOT NULL COMMENT 'The factor by which the amount in the source currency needs to be multiplied, so that the result is in the target currency.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_EXCHANGE_RATE primary key (SOURCE_CURRENCY_CD, TARGET_CURRENCY_CD, EXCHANGE_RATE_TYPE_CD, DWH_VALID_FROM_TMSP)
)COMMENT='Minor Entity - An exchange rate defines the way, how an amount in one currency can be converted into another currency. Exchange rates change frequently. Typically, there are several exchange rates for a given pair of currencies, such as a rate that his offered by a specific financial institution or the daily reference rate of the ECB. - Source - IOTCharger'
;