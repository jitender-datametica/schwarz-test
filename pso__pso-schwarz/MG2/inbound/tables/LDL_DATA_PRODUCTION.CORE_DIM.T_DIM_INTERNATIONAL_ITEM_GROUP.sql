create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_INTERNATIONAL_ITEM_GROUP (
	INT_ITEM_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier [surrogate key] for an international item group.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	INT_ITEM_GRP_NR VARCHAR(100) COMMENT 'The number by which the international item group is known to business.',
	INT_ITEM_GRP_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the international item group in group language, i.e. in German.',
	INT_ITEM_GRP_NAME_DE VARCHAR(100) COMMENT 'The name of the international item group in German.',
	INT_ITEM_GRP_NAME_EN VARCHAR(100) COMMENT 'The name of the international item group in English.',
	PROD_GRP_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status for product groups.',
	PROD_GRP_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status for product groups. (Description in group language, i.e. in German)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_INTERNATIONAL_ITEM_GROUP primary key (INT_ITEM_GRP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='The international item group is the highest level of the item hierarchy. It groups sub item groups.'
;