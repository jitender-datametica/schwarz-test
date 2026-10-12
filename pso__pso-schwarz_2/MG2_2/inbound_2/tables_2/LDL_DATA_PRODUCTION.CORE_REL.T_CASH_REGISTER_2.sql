create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CASH_REGISTER_2 (
	CASH_REGISTER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the cash register.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	CASH_REGISTER_NR NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the cash register.',
	REAL_ESTATE_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CASH_REGISTER primary key (CASH_REGISTER_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A cash register is an electronic device which is used in stores to record sales_2 transactions. It typically includes a bar code scanner, a keyboard, a display and a drawer for money.'
;