create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PLANNED_VALUE_ROLE_2 (
	PLANNED_VAL_ROLE_CD VARCHAR(20) NOT NULL COMMENT 'The code which identifies the role or context for which the value is planned.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PLANNED_VAL_ROLE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the role or context for which the value is planned.',
	constraint PK_T_PLANNED_VALUE_ROLE primary key (PLANNED_VAL_ROLE_CD, LANG_CD)
);