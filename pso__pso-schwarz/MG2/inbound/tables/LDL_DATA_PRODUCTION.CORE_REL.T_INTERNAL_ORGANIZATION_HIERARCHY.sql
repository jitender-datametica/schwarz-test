create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_INTERNAL_ORGANIZATION_HIERARCHY (
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	INT_ORG_HIERARCHY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of hierarchy for internal organizations.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PARENT_INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization, which is one level up in the hierarchy defined by the hierarchy type code.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_INTERNAL_ORGANIZATION_HIERARCHY primary key (INT_ORG_HIERARCHY_TYPE_CD, INT_ORG_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the hierarchy of internal organization units. It relates an internal organization to its parent organization one level up in the hierarchy. This entity can store multiple hierarchies. The kind of hierarchy is identified by the hierarchy type code.'
;