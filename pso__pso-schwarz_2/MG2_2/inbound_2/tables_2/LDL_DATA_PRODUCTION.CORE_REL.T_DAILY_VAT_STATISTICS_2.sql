create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_DAILY_VAT_STATISTICS_2 (
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store, in which the end-of-day processing happens.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_2 organization.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the related business country. (The business country_2 is not identical to a political country.)',
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	STAT_DT DATE NOT NULL COMMENT 'The date when the VAT statistics were collected. ',
	BUS_DT DATE NOT NULL COMMENT 'The business date for which the VAT statistics are generated.',
	CURR_STAT_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.',
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the geographical area to which the tax class applies.',
	TAX_CLASS_CD VARCHAR(20) NOT NULL COMMENT 'The code for the tax class, e.g. Reduced VAT Rate.',
	VAT_STAT_CALC_METHOD_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how the VAT statistics have been calculated.',
	TURNOVER_GROSS_VAL NUMBER(38,5) NOT NULL COMMENT 'The gross turnover in the currency indicated by the currency code, for this store and time period which is taxed with the given VAT class.',
	VAT_VAL NUMBER(38,5) NOT NULL COMMENT 'The resulting VAT amout in the currency indicated by the currency code, for the given store, time period and VAT class.',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DAILY_VAT_STATISTICS primary key (STORE_SID, REAL_ESTATE_SID, BUS_DT, STAT_DT, GEO_AREA_SID, TAX_CLASS_CD, VAT_STAT_CALC_METHOD_CD)
)COMMENT='The event of creating VAT statistics for a given store and a day, showing the gross turnover and the VAT amount for each applicable VAT class.'
;