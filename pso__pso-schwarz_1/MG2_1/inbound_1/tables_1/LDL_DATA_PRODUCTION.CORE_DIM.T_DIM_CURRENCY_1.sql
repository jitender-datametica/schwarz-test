create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_CURRENCY_1 (
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the currency in group language, i.e. in German.',
	CURR_NAME_DE VARCHAR(100) COMMENT 'The name for the currency in german.',
	CURR_NAME_EN VARCHAR(100) COMMENT 'The name for the currency in english.',
	USED_IN_STORES_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if this currency is used in a country_1 where the Schwarz Group operates any stores.',
	EURO_EXCH_RATE NUMBER(38,6) COMMENT 'The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_CURRENCY primary key (CURR_CD)
)COMMENT='This minor dimension defines the currency codes according to ISO-4217. (E.g. EUR, USD, GBP, ...)'
;