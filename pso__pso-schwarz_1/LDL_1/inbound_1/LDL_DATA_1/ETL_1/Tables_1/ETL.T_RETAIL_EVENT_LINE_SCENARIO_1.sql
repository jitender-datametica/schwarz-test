CREATE TABLE ETL.T_RETAIL_EVENT_LINE_SCENARIO_1 (
	RETAIL_EVENT_LINE_SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The numeric identifier for the scenario which is represented by the retail event line.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	RETAIL_EVENT_LINE_SCENARIO_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the business scenario which is represented by the retail event line.',
	RETAIL_EVENT_LINE_SCENARIO_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description of the conditions which determine the business scenario.',
	CONSTRAINT PK_T_RETAIL_EVENT_LINE_SCENARIO PRIMARY KEY (RETAIL_EVENT_LINE_SCENARIO_ID, LANG_CD)
);
