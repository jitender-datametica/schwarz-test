create or replace TABLE LDL_DATA_PRODUCTION.META.T_LOAD_METRIC (
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the execution of an ETL job.',
	LOAD_METRIC_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the type of metric which is collected during the execution of an ETL job.',
	LOAD_METRIC_MEAS NUMBER(38,5) NOT NULL COMMENT 'The value for the metric that has been collected during the execution of the ETL job.',
	UOM_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the unit of measure.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_LOAD_METRIC primary key (LOAD_METRIC_TYPE_CD, LOAD_ID)
)COMMENT='Various statistics can be collected during the execution of an ETL job, such as the CPU or memory usage. The type of metric is defined by the metric type code.'
;