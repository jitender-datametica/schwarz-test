create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_COUNTRY_1 (
	ISO_COUNTRY_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the country_1 according to ISO 3166.',
	COUNTRY_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the country_1 is known, in group language, i.e. German',
	COUNTRY_NAME_DE VARCHAR(100) COMMENT 'The name by which the country_1 is known, in German.',
	COUNTRY_NAME_EN VARCHAR(100) COMMENT 'The name by which the country_1 is known, in English.',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
	OFFICIAL_LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the primary language which is used in this country.',
	STORES_EXIST_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the Schwarz Group operates any stores in this country.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_COUNTRY primary key (ISO_COUNTRY_CD)
)COMMENT='A political country_1, i.e. a geopolitical region_1 with a sovereign governing. E.g. Germany, France, UK, ...'
;