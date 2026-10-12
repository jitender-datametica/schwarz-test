

CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_cntl_etl_logging_2 (
run_id_seq BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Sequence number of ETL processing - based on SEQ_CNTL_ETL_LOGGING (see CNTL_ETL_LOGGING_RUN_SEQ)'),
run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Execution timestamp. Start of daily ETL processing (see ETL_LOGGING_RUN_SEQ)'),
run_day_id DATE DEFAULT CAST('8888-12-31' AS DATE) NOT NULL
OPTIONS(description='Execution day. Format YYYY-MM_2-DD (see ETL_LOGGING_RUN_SEQ).'),
run_clustering_desc STRING(16777216) DEFAULT '[0]' NOT NULL
OPTIONS(description='Execution cluster in case of parallel execution. Format [ cluster name ]. (see ETL_LOGGING_RUN_SEQ).'),
application_name STRING(16777216) DEFAULT 'PITonPrem' NOT NULL
OPTIONS(description='General name of the application (see ETL_LOGGING_RUN_SEQ) Name of Application --> Module --> Component'),
module_name STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Name of the program module. Example: POS cash register data processing. Module Name --> Component.'),
component_name STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Name of the program component of a program module. Example: POS-ReceiptLine processing'),
start_run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Start timestamp of processing'),
end_run_ts DATETIME OPTIONS(description='End timestamp of processing'),
run_time_min BIGNUMERIC(38,0) OPTIONS(description='[VC] Execution time in minutes'),
run_time_sec BIGNUMERIC(38,0) OPTIONS(description='[VC] Execution time in seconds'),
query_tag STRING(16777216) OPTIONS(description='Querytag'),
sf_user STRING(16777216) DEFAULT 'SESSION_USER()' NOT NULL
OPTIONS(description='Snowflake User - Default =  SESSION_USER()'),
sf_warehouse STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Warehouse - Default = "N/A"'),
sf_role STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Role - Default = "N/A"'),
sf_database STRING(16777216) DEFAULT 'ldl' NOT NULL
OPTIONS(description='Snowflake Database - Default = ldl'),
sf_schema STRING(16777216) DEFAULT 'p_lew_mart_pit_onprem' NOT NULL
OPTIONS(description='Snowflake Schema - Default = p_lew_mart_pit_onprem'),
sf_session STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Session - Default = @@bq_job_id'),
sf_client STRING(16777216) DEFAULT 'CURRENT_CLIENT()' NOT NULL
OPTIONS(description='Snowflake Client - Default = CURRENT_CLIENT()'),
record_processed_nr BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Number of processed Records'),
run_ldesc STRING(16777216)
OPTIONS(description='[VC] Description of the run. Example:\'ETL Run 10 on Thursday 2021-JUL-26 15:37:04.6789\' '),
start_processig_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator of the start of the loading run. [0|1]'),
end_processig_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator of the end of the loading run. [0|1]'),
module_level_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator level Module. [0|1]'),
component_level_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator level Component. [0|1]'),
completed_run_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator that loading run is completed. [0|1]'),
moving_run_id_from_current BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='[View] Current ID = 0 previous Run IDs are -1,-2,etc.'),
reject_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Logical Deleted Flag; indicates if the record was logically deleted'),
deleted_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / AB>Initio Process ID'),
PRIMARY KEY (run_id_seq, run_day_id, deleted_fg) NOT ENFORCED
) OPTIONS(description='Central ETL Logging Table, holding the start and end timestamps, and the execution run time.');



