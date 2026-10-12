create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_PARAMETER_STATUS_TYPE (
	PARAM_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status of a parameter value if it is approved, requested or denied.',
	PARAM_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'The short name of parameter value status.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_PARAMETER_STATUS_TYPE primary key (PARAM_STATUS_CD)
)COMMENT='The entity definies the lifecycle of the fraud detection parameter.'
;