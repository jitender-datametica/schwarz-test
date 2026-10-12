create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM_VARIANT_STATUS_TYPE (
	WAWI_ITEM_VARIANT_STATUS_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the lifecycle status for Wawi item variants.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	WAWI_ITEM_VARIANT_STATUS_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the lifecycle status for Wawi item variants.',
	WAWI_ITEM_VARIANT_STATUS_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status for Wawi item variants.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_WAWI_ITEM_VARIANT_STATUS_TYPE primary key (WAWI_ITEM_VARIANT_STATUS_TYPE_ID, LANG_CD)
)COMMENT='This minor entity defines the lifecycle status for Wawi item variants. This includes both global (HQ) statuses and regional / warehouse (WH) statuses.'
;