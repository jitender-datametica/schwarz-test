create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_DISPATCH_GROUP_1 (
	PROD_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DISPATCH_GRP_NR VARCHAR(20) NOT NULL COMMENT 'The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_DISPATCH_GROUP primary key (PROD_SID, INT_ORG_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity associates a product with its dispatch group. A dispatch group defines a group of products which are handled together in the logistics process.'
;