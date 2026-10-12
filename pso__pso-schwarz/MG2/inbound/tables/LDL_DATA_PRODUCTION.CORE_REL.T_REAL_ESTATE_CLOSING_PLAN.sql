create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_REAL_ESTATE_CLOSING_PLAN (
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	CLOSED_FROM_DT DATE NOT NULL COMMENT 'The start date (inclusive) of the interval for which the real estate object will be closed.',
	CLOSED_UNTIL_DT DATE NOT NULL COMMENT 'The end date (inclusive) of the interval for which the real estate object will be closed.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	CLOSED_BUS_DAYS_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of business days the real estate object will remain closed - which it would otherwise have been open.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REAL_ESTATE_CLOSING_PLAN primary key (REAL_ESTATE_SID, CLOSED_FROM_DT, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the planned closing of a real estate object.'
;