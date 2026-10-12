create or replace TABLE LDL_DATA_PRODUCTION.META.T_CARDINALITY (
	CARDINALITY_CD VARCHAR(5) NOT NULL COMMENT 'A code identifying the cardinality, i.e. 1:1, 1:n or n:m',
	CARDINALITY_NAME VARCHAR(100) NOT NULL COMMENT 'The full text name for the cardinality, i.e. one-to-one, one-to-many or many-to-many.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CARDINALITY primary key (CARDINALITY_CD)
)COMMENT='The cardinality of a relationship defines, how many instances of the one data structures are related with how many instances of the other data structures. Cardinalities may be 1:1, 1:n and n:m.'
;