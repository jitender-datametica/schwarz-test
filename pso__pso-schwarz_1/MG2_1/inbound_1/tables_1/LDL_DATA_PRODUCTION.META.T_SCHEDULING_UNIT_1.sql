create or replace TABLE LDL_DATA_PRODUCTION.META.T_SCHEDULING_UNIT_1 (
	SCHEDULING_UNIT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of ETL jobs that are always executed together.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SCHEDULING_UNIT_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the scheduling unit_1 in the ETL tool.',
	SCHEDULING_UNIT_DESCR VARCHAR(250) COMMENT 'A textual description of the scheduling unit_1, detailing its purpose and structure.',
	SCHEDULING_FREQ_CD VARCHAR(20) NOT NULL COMMENT 'A code defining, how often a scheduling unit_1 is executed. E.g daily, weekly, ...',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_SCHEDULING_UNIT primary key (SCHEDULING_UNIT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A scheduling unit_1 is a group of ETL jobs which are always executed together.'
;