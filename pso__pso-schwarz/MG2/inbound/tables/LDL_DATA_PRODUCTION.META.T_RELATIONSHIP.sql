create or replace TABLE LDL_DATA_PRODUCTION.META.T_RELATIONSHIP (
	REL_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the relationship',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	REL_NAME VARCHAR(100) COMMENT 'The name for the relationship, as it has been defined in the data model',
	CARDINALITY_CD VARCHAR(5) NOT NULL COMMENT 'A code identifying the cardinality, i.e. 1:1, 1:n or n:m',
	DATA_STRUCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the first data structure.',
	DATA_STRUCT_NULLABLE_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the (first) data object is optional, If it is false, then a relationship must exist for each instance of the first data object.',
	REL_DATA_STRUCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the second data structure.',
	REL_DATA_STRUCT_NULLABLE_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the related (second) data object is optional. If it is false, then a relationship must exist for each instance of the second data object.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_RELATIONSHIP primary key (REL_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A relationship connects two data structures (of the same type). '
;