create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_FLAG_2 (
	FG BOOLEAN NOT NULL COMMENT 'The flag (true or false)',
	FG_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the flag (yes / no) in group language, i.e. German.',
	FG_NAME_DE VARCHAR(100) COMMENT 'The name for the flag (yes / no) in.German.',
	FG_NAME_EN VARCHAR(100) COMMENT 'The name for the flag (yes / no) in English.',
	FG_SHORT_NAME VARCHAR(100) NOT NULL COMMENT 'The abbreviation for the flag (Y/N) in group language, i.e. German.',
	FG_SHORT_NAME_DE VARCHAR(100) COMMENT 'The abbreviation for the flag (Y/N) in.German.',
	FG_SHORT_NAME_EN VARCHAR(100) COMMENT 'The abbreviation for the flag (Y/N) in English.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_FLAG primary key (FG)
)COMMENT='If the frontend requires a list of values for flags (i.e. true and false), this minor dimension can be used as a lookup.'
;