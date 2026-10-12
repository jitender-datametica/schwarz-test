create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_RETAIL_EVENT_LINE_SCENARIO_1 (
	RETAIL_EVENT_LINE_SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The numeric identifier for the scenario which is represented by the retail event line.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	RETAIL_EVENT_LINE_SCENARIO_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the business scenario which is represented by the retail event line.',
	RETAIL_EVENT_LINE_SCENARIO_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description of the conditions which determine the business scenario.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	RETAIL_EVENT_LINE_SCENARIO_SHORT_NAME VARCHAR(100) COMMENT 'A short or alternative name for the business scenario which is represented by the retail event line.',
	constraint PK_T_RETAIL_EVENT_LINE_SCENARIO primary key (RETAIL_EVENT_LINE_SCENARIO_ID, LANG_CD)
)COMMENT='This minor entity defines the business scenario which the retail event line represents, e.g. regular sales_1 of a product, return of a product, discount, etc. The scenario is calculated from a number of other attributes, so it is derived information.'
;