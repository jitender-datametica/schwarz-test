create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_SUB_ITEM_GROUP (
	SUB_ITEM_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a sub item group',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SUB_ITEM_GRP_NR VARCHAR(100) COMMENT 'The number by which the sub item group is known to business.',
	SUB_ITEM_GRP_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the sub item group in group language, i.e. in German.',
	SUB_ITEM_GRP_NAME_DE VARCHAR(100) COMMENT 'The name of the sub item group in German.',
	SUB_ITEM_GRP_NAME_EN VARCHAR(100) COMMENT 'The name of the sub item group in English,',
	FOOD_FG BOOLEAN NOT NULL COMMENT 'An indicator distinguishing food from non-food items.',
	PROD_GRP_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status for product groups.',
	PROD_GRP_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status for product groups. (Description in group language, i.e. in German)',
	INT_ITEM_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the international item group to which this sub item group belongs.',
	INT_ITEM_GRP_NR VARCHAR(100) COMMENT 'The number by which the related international item group is known to business.',
	INT_ITEM_GRP_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the related international item group in group language, i.e. in German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_SUB_ITEM_GROUP primary key (SUB_ITEM_GRP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A sub item group rolls up several item family groups.'
;