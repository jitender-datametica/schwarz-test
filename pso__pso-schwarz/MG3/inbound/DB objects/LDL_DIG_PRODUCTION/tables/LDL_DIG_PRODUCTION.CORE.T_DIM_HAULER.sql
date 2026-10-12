create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_HAULER (
	HAULER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for hauler',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	HAULER_NAME VARCHAR(100) COMMENT 'The name by which the transport carrier is known',
	HAULER_COUNTRY_CD VARCHAR(5) COMMENT 'The country code of the transport carrier, where it is operating in',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source tables',
	constraint PK_T_DIM_HAULER primary key (HAULER_SID, DWH_VALID_FROM_TMSP)
)COMMENT='carrier provider (KEP)'
;