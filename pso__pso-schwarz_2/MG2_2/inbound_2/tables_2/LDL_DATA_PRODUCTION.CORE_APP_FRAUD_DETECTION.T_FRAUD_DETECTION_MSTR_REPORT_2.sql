create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_REPORT_2 (
	REPORT_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of MicroStrategy Report',
	REPORT_GRP_ID NUMBER(38,0) COMMENT 'The unique identifier of fraud detection scenario group.',
	REPORT_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the report which will be used by the navigation.',
	REPORT_DESCR VARCHAR(250) NOT NULL COMMENT 'Describes the report.',
	REPORT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'Type of report, code which defines if it is developed for manual or automatic for different layers',
	REPORT_OFFSET NUMBER(38,0) COMMENT 'The sequence number of the report, in which order it will be displayed',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_MSTR_REPORT primary key (REPORT_ID)
)COMMENT='Keeps the fraud detection metrics for MicroStrategy Dynamic Dashboards '
;