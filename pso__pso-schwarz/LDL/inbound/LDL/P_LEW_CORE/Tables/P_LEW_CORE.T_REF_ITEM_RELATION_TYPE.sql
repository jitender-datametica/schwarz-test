create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_ITEM_RELATION_TYPE (
	ITEM_REL_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'Source relationship type number, which identifies the type of the relationship between the parent item and the child item.',
	ITEM_REL_TYPE_GRP_CD VARCHAR(100) NOT NULL COMMENT 'The relationship type group code that arranges the relationship types for a combining property, like source system or table.',
	ITEM_REL_TYPE_DESCR VARCHAR(250) COMMENT 'Descriptioin of the relationship type of the relation between the parent item and the child item.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_ITEM_RELATION_TYPE primary key (ITEM_REL_TYPE_CD, ITEM_REL_TYPE_GRP_CD)
)COMMENT='This table constains the relationship type of the relation between the Parent Item with the Child Item.\n             Manually filled with values derived from the source.'
;
