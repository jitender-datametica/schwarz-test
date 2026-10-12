CREATE TABLE ETL_PROCESS.T_TCACHE_SAPHANA_CV_CUBE_KER_STAT_CDWH_SNAP_1 (
	EXTRACTION_TS TIMESTAMP_NTZ(6),
	EXTRACTION_DATE DATE,
	SOURCE_SYSTEM VARCHAR(100000),
	BIC_ZMLILA VARCHAR(100000),
	CALMONTH VARCHAR(100000),
	LOAD_ID FLOAT,
	GXXMLKLAG VARCHAR(100000),
	VLXMLCNTR VARCHAR(100000),
	UNIT_1 VARCHAR(100000),
	IST FLOAT,
	PLAN FLOAT,
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
);
