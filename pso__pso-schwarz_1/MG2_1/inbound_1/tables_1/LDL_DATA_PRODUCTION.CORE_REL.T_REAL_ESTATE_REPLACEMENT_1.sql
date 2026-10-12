create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_REAL_ESTATE_REPLACEMENT_1 (
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	REPLACEMENT_REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object which replaces the other object.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	REAL_ESTATE_REPLACEMENT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REAL_ESTATE_REPLACEMENT primary key (REAL_ESTATE_SID, REPLACEMENT_REAL_ESTATE_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the real estate object(s) which replace other objects.There are two types of replacments: Relocations and demolition and a new construction. (The type of replacement is defined by the replacement type code.)'
;