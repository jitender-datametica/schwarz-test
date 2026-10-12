create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_RESOURCE_ITEM_COST_2 (
	RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item.',
	COST_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of cost.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	COST_VAL NUMBER(38,5) NOT NULL COMMENT 'The cost amount.',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
	RESOURCE_ITEM_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for resource items.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_RESOURCE_ITEM_COST primary key (COST_TYPE_CD, RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks costs which are associated with a resource item. E.g. rental costs for a real estate object.'
;