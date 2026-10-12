create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_ITEM_RELATION_TYPE_GROUP (
	ITEM_REL_TYPE_GRP_CD VARCHAR(100) NOT NULL COMMENT 'The relationship type group code that arranges the relationship types for a combining property, like source system or table.',
	ITEM_REL_TYPE_GRP_DESCR VARCHAR(250) COMMENT 'The relationship type group description for arranged relationship types.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_ITEM_RELATION_TYPE_GROUP primary key (ITEM_REL_TYPE_GRP_CD)
)COMMENT='The relationship type group arranges the relationship types via a combining property, like source system or table.\n             Manually filled.'
;
