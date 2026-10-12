create or replace TABLE LDL_DATA_PRODUCTION.META.T_WAWI_ITEM_KEY_TYPE_1 (
	WAWI_ITEM_KEY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the type of natural key which identifies the Wawi Item.',
	WAWI_ITEM_KEY_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the type of natural key which identifies the Wawi Item.',
	WAWI_ITEM_KEY_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_WAWI_ITEM_KEY_TYPE primary key (WAWI_ITEM_KEY_TYPE_CD)
)COMMENT='This minor entity defines the type of natural key which identifies a Wawi Item.'
;