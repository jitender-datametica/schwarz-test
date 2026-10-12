create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PLANNED_VALUE_TYPE_1 (
	KPI_COLUMN_NAME VARCHAR(100),
	KEY_TYPE_CD VARCHAR(20),
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PLANNED_VAL_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of value for which a plan is made.',
	PLANNED_VAL_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the kind of value for which a plan is made in the planning tool. E.g. 157 for net revenue.',
	PLANNED_VAL_ROLE_CD VARCHAR(20) COMMENT 'The code which identifies the role or context for which the value is planned.',
	PLANNING_PROCESS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the planning process which defines this planned value type.'
);