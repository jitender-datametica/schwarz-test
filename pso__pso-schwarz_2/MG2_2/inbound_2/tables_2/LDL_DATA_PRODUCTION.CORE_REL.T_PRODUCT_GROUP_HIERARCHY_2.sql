create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_GROUP_HIERARCHY_2 (
	PROD_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of marketable products or services.',
	PROD_GRP_HIERARCHY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of hierarchy_2 for product groups.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PARENT_PROD_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of marketable products or services, which is one level up in the hierarchy_2 defined by the hierarchy_2 type code.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_GROUP_HIERARCHY primary key (PROD_GRP_HIERARCHY_TYPE_CD, PROD_GRP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the hierarchy_2 of product groups. It relates a group of products to its parent group one level up in the hierarchy. This entity can store multiple hierarchies. The kind of hierarchy_2 is identified by the hierarchy_2 type code.'
;