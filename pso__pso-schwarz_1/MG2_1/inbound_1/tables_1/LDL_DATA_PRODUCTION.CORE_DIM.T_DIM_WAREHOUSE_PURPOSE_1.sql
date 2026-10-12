create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_WAREHOUSE_PURPOSE_1 (
	WH_PURPOSE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the purpose of a warehouse.',
	WH_PURPOSE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the purpose of a warehouse. (Description in group language, i.e. in German)',
	WH_PURPOSE_DESCR_DE VARCHAR(250) COMMENT 'A textual description for the purpose of a warehouse. (Description in German)',
	WH_PURPOSE_DESCR_EN VARCHAR(250) COMMENT 'A textual description for the purpose of a warehouse. (Description in English)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_WAREHOUSE_PURPOSE primary key (WH_PURPOSE_CD)
)COMMENT='This minor dimension defines the main purposes which a warehouse may serve. E.g. crossdock, import warehouse, etc.'
;