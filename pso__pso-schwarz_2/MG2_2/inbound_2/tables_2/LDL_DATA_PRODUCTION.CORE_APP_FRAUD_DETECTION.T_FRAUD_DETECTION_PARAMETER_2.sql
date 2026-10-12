create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_PARAMETER_2 (
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of fraud detection scenario.',
	PARAM_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of parameter (thereshold) of a scenario',
	PARAM_NAME VARCHAR(100) NOT NULL COMMENT 'The name of a scenario parameter',
	PARAM_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of scenario paramter.',
	PARAM_DEFAULT_VAL_QTY NUMBER(38,5) COMMENT 'The default value of a scenario parameter.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_PARAMETER primary key (PARAM_ID)
)COMMENT='One scenario defines one or several parameters.Several scenarios can use parameters with the same name.'
;