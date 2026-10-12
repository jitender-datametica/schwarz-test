create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_PARAMETER_VALUE_2 (
	PARAM_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of parameter (thereshold) of a scenario',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the related business country. (The business country_2 is not identical to a political country_2',
	PARAM_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The status_2 of a parameter value if it is approved, requested or denied.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PARAM_VAL_QTY NUMBER(38,5) COMMENT 'The value of scenario parameter, which is provided by end user.',
	REQUESTOR_USER_NAME VARCHAR(100) COMMENT 'The MSTR-User who enters the value to the system',
	REQUEST_TMSP TIMESTAMP_TZ(9) COMMENT 'The point of the time, when the entry is done.',
	APPROVER_USER_NAME VARCHAR(100) COMMENT 'The MSTR-User who approves the value entered to the system',
	APPROVED_TMSP TIMESTAMP_TZ(9) COMMENT 'The point of the time when the entry is approved.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_PARAMETER_VALUE primary key (PARAM_ID, COUNTRY_ORG_CD, PARAM_STATUS_CD, DWH_VALID_FROM_TMSP)
)COMMENT='A parameter can have a value which then impact the scenario result'
;