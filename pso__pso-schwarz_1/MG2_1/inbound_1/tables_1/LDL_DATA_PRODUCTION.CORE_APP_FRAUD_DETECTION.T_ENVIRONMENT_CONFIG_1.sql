create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_ENVIRONMENT_CONFIG_1 (
	PARAM_NAME VARCHAR(100) NOT NULL COMMENT 'Holds the parameter value, E.g. param_name warehouse size and param_val_txt would have a XL or M.',
	PARAM_VAL_TXT VARCHAR(1000) NOT NULL COMMENT 'Holds the parameter value, E.g. XL for the parameter value for the param_name warehouse size.',
	COMMENT_TXT VARCHAR(1000) COMMENT 'Detail description of the parameter.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_ENVIRONMENT_CONFIG primary key (PARAM_NAME)
)COMMENT='Holds the ZKP Application parameter values.'
;