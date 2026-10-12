CREATE TABLE ETL_PROCESS.T_DELTA_CONTROL_SCORE_2 (
	SRC_TABLE VARCHAR(100) NOT NULL COMMENT 'Source table',
	SRC_SYSTEM VARCHAR(30) NOT NULL COMMENT 'Source system',
	MAX_EXTRACTION_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The maximum extraction timestamp of previous load',
	PRIMARY KEY (SRC_TABLE, SRC_SYSTEM)
)COMMENT='ETL table to keep the maximum timestamp of extraction and load.'
;