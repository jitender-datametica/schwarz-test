create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_ERRORS_RESOURCE_ITEM_KEY_2 (
	RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item.',
	RESOURCE_ITEM_KEY_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the type of natural key which identifies the resource item.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	RESOURCE_ITEM_NAT_KEY_NR VARCHAR(250) NOT NULL COMMENT 'The natural key which identifies the resource item.In case the natural key consist of several columns, all components get concatenated.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	constraint PK_RESOURCE_ITEM_KEY primary key (RESOURCE_ITEM_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, RESOURCE_ITEM_NAT_KEY_NR)
);