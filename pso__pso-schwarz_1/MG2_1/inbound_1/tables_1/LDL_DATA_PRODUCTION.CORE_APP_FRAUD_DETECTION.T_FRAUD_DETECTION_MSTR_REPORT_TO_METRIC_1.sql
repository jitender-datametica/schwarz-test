create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_REPORT_TO_METRIC_1 (
	REPORT_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of MicroStrategy Report',
	METRIC_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of microstratey metric',
	METRIC_OFFSET NUMBER(38,0) NOT NULL,
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_MSTR_REPORT_TO_METRIC primary key (REPORT_ID, METRIC_ID)
)COMMENT='Keeps the information which metrics will be presented on which report'
;