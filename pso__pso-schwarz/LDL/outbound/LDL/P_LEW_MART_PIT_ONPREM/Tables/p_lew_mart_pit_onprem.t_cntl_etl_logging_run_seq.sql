CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_cntl_etl_logging_run_seq (
run_id_seq BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Sequential number of ETL processing - based on SEQ_ETL_LOGGING'),
run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Execution timestamp. Start of daily ETL processing'),
run_day_id DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Execution date. Format YYYY-MM-DD'),
run_clustering_desc STRING(16777216) DEFAULT '[0]' NOT NULL
OPTIONS(description='Execution cluster in case of parallel execution. Format [ Cluster name ]'),
application_name STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='General name of the application. PITonCloud'),
PRIMARY KEY (run_id_seq, run_ts) NOT ENFORCED
)
OPTIONS(description='ELT Control Table holding the sequence number. SF Workaround Holding the current RUN_SEQ_ID, which is UNIQUE per ELT-Daily (and/or Initial) processing. Important: the RUN_SEQ_ID is based on the sequence SEQ_ETL_LOGGING.');