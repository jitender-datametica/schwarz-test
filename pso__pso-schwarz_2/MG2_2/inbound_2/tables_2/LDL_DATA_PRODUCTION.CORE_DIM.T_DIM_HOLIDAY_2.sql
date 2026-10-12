create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_HOLIDAY_2 (
	HOLIDAY_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the holiday in group language, i.e. German.',
	HOLIDAY_NAME_DE VARCHAR(100) COMMENT 'A name for the holiday in German.',
	HOLIDAY_NAME_EN VARCHAR(100) COMMENT 'A name for the holiday in English.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_HOLIDAY primary key (HOLIDAY_NAME)
)COMMENT='This minor dimension defines the holidays. E.g. Christmas, Easter Sunday, ...'
;