create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_SHELFLIFE_REQUIREMENT_1 (
	PROD_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization, for which the minimum shelflife is defined.',
	SHELFLIFE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the condition on which a minimum shelflife is defined.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SHELFLIFE_DAY_CNT NUMBER(38,0) COMMENT 'The minimum shelflife of the product in days.',
	STANDARD_SHELFLIFE_FG BOOLEAN COMMENT 'An indicator showing, if this is the standard shelflife.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_SHELFLIFE_REQUIREMENT primary key (INT_ORG_SID, PROD_SID, SHELFLIFE_TYPE_CD, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the minimum shelflife conditions for a product. E.g. a product may only be offered in a store, if its shelflife is longer than x days. Or it may only be delivered from the warehouse to the store, if its shelflife is longer than y days. The shilflife type defines the condition.'
;