create or replace TABLE LDL_DATA_PRODUCTION.META.T_TRANSFORMATION (
	TRANSFORM_CD VARCHAR(20) NOT NULL COMMENT 'A code identifying the set of rules and algorithms which define, how a data object is converted into another data object.',
	TRANSFORM_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the set of rules and algorithms which define, how a data object is converted into another data object.',
	TRANSFORM_DESCR VARCHAR(250) COMMENT 'A textual description which describes how the transformation is to be used.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_TRANSFORMATION primary key (TRANSFORM_CD)
)COMMENT='The transformation defines the set of rules and algorithms which are used to convert one data object into another one. This may include joins, filters and aggregations as well as calculations or formatting operations. Transformations may be defined on the level of data objects or for data elements.'
;