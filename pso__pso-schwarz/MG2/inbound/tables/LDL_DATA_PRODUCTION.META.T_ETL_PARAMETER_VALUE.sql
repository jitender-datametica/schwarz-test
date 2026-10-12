create or replace TABLE LDL_DATA_PRODUCTION.META.T_ETL_PARAMETER_VALUE (
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the execution of an ETL job.',
	PSET_NAME VARCHAR(100) NOT NULL COMMENT 'The name which uniquely identifies the parameter set.',
	PARAM_NAME VARCHAR(100) NOT NULL COMMENT 'The name which uniquely identifies the parameter.',
	PARAM_TXT VARCHAR(1000) NOT NULL COMMENT 'The value which has been used for the given parameter.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_ETL_PARAMETER_VALUE primary key (LOAD_ID, PSET_NAME, PARAM_NAME)
)COMMENT='When an ETL job is executed, its parameters get substituted. This entity tracks the parameter values which have been used for each run.'
;