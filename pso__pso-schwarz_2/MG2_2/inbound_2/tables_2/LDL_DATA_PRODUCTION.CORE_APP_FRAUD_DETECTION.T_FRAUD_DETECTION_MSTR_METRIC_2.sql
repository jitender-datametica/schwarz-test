create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_METRIC_2 (
	METRIC_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of microstratey metric',
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
	METRIC_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the microstrategy metric presented at frontend.',
	METRIC_DESCR VARCHAR(250) NOT NULL COMMENT 'Describes the MicroStrategy Metric.',
	CALCULATION_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'Type of calculation, code which defines type of calculation like SUM, weighted Average, count',
	FORMAT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'Type of format, code which defines metric format like integer, percent, currency',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_MSTR_METRIC primary key (METRIC_ID)
)COMMENT='Keeps the fraud detection metrics for MicroStrategy Dynamic Dashboards '
;