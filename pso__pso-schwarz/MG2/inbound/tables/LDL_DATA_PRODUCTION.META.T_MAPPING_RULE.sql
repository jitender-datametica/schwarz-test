create or replace TABLE LDL_DATA_PRODUCTION.META.T_MAPPING_RULE (
	MAP_GRP_NAME VARCHAR(100) NOT NULL COMMENT 'The name which describes the purpose of the mapping group.',
	MAP_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the mapping, i.e. for the set of rules and algorithms which specify, how one or several source data structures are transformed into a target data structure. (Typically, there is one mapping for each target table.)',
	BLOCK_NR NUMBER(38,0) NOT NULL COMMENT 'The identifier of the mapping block within a mapping',
	TGT_DATA_OBJ_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the target data object.',
	SRC_DATA_OBJ_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the source data object.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	TRANSFORM_CD VARCHAR(20) COMMENT 'A code identifying the set of rules and algorithms which define, how a data object is converted into another data object.',
	TRANSFORM_PARAM_TXT VARCHAR(1000) COMMENT 'A transformation may use a parameter, e.g. a factor for a calculation or a join condition.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_MAPPING_RULE primary key (MAP_GRP_NAME, MAP_NAME, BLOCK_NR, SRC_DATA_OBJ_SID, TGT_DATA_OBJ_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A mapping rule defines how a specific target data object is derived. A mapping rule belongs to a block in a mapping. Mapping Rules can be defined on the level of data structures (a.k.a. block level transformations) or for data elements. A target data object may depend on one or on several input data objects.'
;