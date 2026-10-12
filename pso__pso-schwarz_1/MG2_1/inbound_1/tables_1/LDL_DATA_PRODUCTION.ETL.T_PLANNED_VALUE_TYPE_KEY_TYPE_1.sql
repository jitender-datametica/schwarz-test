create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PLANNED_VALUE_TYPE_KEY_TYPE_1 (
	PLANNED_VAL_TYPE_KEY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the type of natural key which identifies the Planned Value Type.',
	PLANNED_VAL_TYPE_KEY_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the type of natural key which identifies the Planned Value Type.',
	PLANNED_VAL_TYPE_KEY_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
	constraint PK_T_PLANNED_VALUE_TYPE_KEY_TYPE primary key (PLANNED_VAL_TYPE_KEY_TYPE_CD)
);