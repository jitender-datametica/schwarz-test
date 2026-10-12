create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_DIM_EXCHANGE_RATE_TEMP_1 (
	DWH_VALID_FROM_DT DATE NOT NULL COMMENT 'The date when this record became valid.',
	DWH_VALID_TO_DT DATE NOT NULL COMMENT 'The date when this record was no longer valid.',
	ACTIVE_FROM_DT DATE NOT NULL COMMENT 'The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).',
	ACTIVE_TO_DT DATE NOT NULL COMMENT 'The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).',
	CURR_CD_FROM VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_CD_TO VARCHAR(3) NOT NULL COMMENT 'The code identifying the target currency according to ISO-4217.',
	EXCHANGE_RATE NUMBER(38,5) COMMENT 'The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_EXCHANGE_RATE primary key (DWH_VALID_FROM_DT, ACTIVE_FROM_DT, CURR_CD_FROM, CURR_CD_TO)
);