CREATE TABLE ETL_PROCESS.T_TCACHE_GPS_TIME_TYPE_SNAP_2 (
	BIC_ZMLILA VARCHAR(1000),
	WH_ID NUMBER(10,0),
	MISSINGTYPE_ID NUMBER(38,0),
	MISSINGTYPE_SHORT_DESC VARCHAR(1000),
	MISSINGTYPE_DESC VARCHAR(1000),
	SAP_CD VARCHAR(1000),
	PRESENCE_FG NUMBER(38,0),
	MISSINGTYPE_PERF_REL_FG NUMBER(38,0),
	EXTRACTION_TS TIMESTAMP_LTZ(6),
	ACTIVE_FROM DATE NOT NULL,
	ACTIVE_TO DATE NOT NULL,
	PROCESSED_FG NUMBER(38,0),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
);