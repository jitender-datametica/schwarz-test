CREATE TABLE P_LEW_MART_PIT_ONPREM.T_CNTL_ETL_LOGGING_RUN_SEQ_1 (
	RUN_ID_SEQ NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Sequential number of ETL processing - based on SEQ_ETL_LOGGING',
	RUN_TS TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'Execution timestamp. Start of daily ETL processing',
	RUN_DAY_ID DATE NOT NULL DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') COMMENT 'Execution date. Format YYYY-MM_1-DD',
	RUN_CLUSTERING_DESC VARCHAR(16777216) NOT NULL DEFAULT '[0]' COMMENT 'Execution cluster in case of parallel execution. Format [ Cluster name ]',
	APPLICATION_NAME VARCHAR(16777216) NOT NULL DEFAULT 'N/A' COMMENT 'General name of the application. PITonCloud',
	UNIQUE (RUN_ID_SEQ),
	CONSTRAINT T_CNTL_ETL_LOGGING_RUN_SEQ_PK PRIMARY KEY (RUN_ID_SEQ, RUN_TS)
)COMMENT='ELT Control Table holding the sequence number. SF Workaround Holding the current RUN_SEQ_ID, which is UNIQUE per ELT-Daily (and/or Initial) processing. Important: the RUN_SEQ_ID is based on the sequence SEQ_ETL_LOGGING.'
;