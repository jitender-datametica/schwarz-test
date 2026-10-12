create or replace TABLE LDL_DATA_PRODUCTION.META.T_TEST_ORIGIN (
	TEST_ORIGIN_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
	TEST_ORIGIN_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the operational source which defines the test.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_TEST_ORIGIN primary key (TEST_ORIGIN_CD)
)COMMENT='This minor entity defines the operational sources which defines the tests. E.g. a data quality rule can be defined in the Ab Initio DQ framework or in Informatica.'
;