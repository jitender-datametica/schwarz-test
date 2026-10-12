/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDLs for CNTL_CNTL_ETL_LOGGING structures.
#-------------------------------------------------------------------------------
# Description: DDLs for ETL Logging Control structures:
#                   FUNCTION f_QueryTag
#                   Sequence SEQ_CNTL_ETL_LOGGING
#                   TABLE P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_RUN_SEQ
#                   TABLE P_LEW_MART_PIT.T_CNTL_ETL_LOGGING
#                   Logging Procedures
#                   View V_CNTL_ETL_LOGGING
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-27 Andreas Kurz    	Initial version
#  1.1  2021-08-16 Dirk Hering     	Fixes, formatting
#  1.2  2021-08-18 Andreas Kurz		Added Nr. of Processed Records
#									Changed the Procedures
#  2.0	2022-07-13 Nikolai Toknov  	Changing the script for DevOps
#  2.5  2022-09-17 Andreas Kurz		Changed additional columns MULTI_CLIENT
#  2.6  2023-08-14 Andreas Kurz 	Added new columns for changed Logging mechanism
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
RUN_TIME_MIN
RUN_TIME_SEC
RUN_LDESC
MULTI_CLIENT_RUN_LST_NR
MULTI_CLIENT_RUN_LST_DESCR
MULTI_CLIENT_RUN_FG
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_etl_logging (
run_id_seq INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Sequence NUMBER of ETL processing - based on SEQ_CNTL_ETL_LOGGING (see CNTL_ETL_LOGGING_RUN_SEQ)'),
run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Execution timestamp. Start of daily ETL processing (see ETL_LOGGING_RUN_SEQ)'),
run_day_id DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Execution day. Format YYYY-MM-DD (see ETL_LOGGING_RUN_SEQ).'),
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
multi_client_run_lst ARRAY < STRING >OPTIONS(description='Executed Client ID(s) in case of multiple Client IDs will be executed'),
run_clustering_desc STRING(16777216) DEFAULT '[0]' NOT NULL
OPTIONS(description='Execution cluster in case of parallel execution. Format [ cluster name ]. (see ETL_LOGGING_RUN_SEQ).'),
application_name STRING(16777216) DEFAULT 'PITonCloud' NOT NULL
OPTIONS(description='General name of the application (see ETL_LOGGING_RUN_SEQ) Name of Application --> Module --> Component'),
module_name STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Name of the program module. Example: POS cash register data processing. Module Name --> Component.'),
component_name STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Name of the program component of a program module. Example: POS-ReceiptLine processing'),
start_run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Start timestamp of processing'),
end_run_ts DATETIME OPTIONS(description='End timestamp of processing'),
query_tag STRING(16777216) OPTIONS(description='Querytag'),
sf_user STRING(16777216) DEFAULT SESSION_USER() NOT NULL
OPTIONS(description='Snowflake User - DEFAULT =  CURRENT_USER()'),
sf_warehouse STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Warehouse - DEFAULT = CURRENT_WAREHOUSE()'),
sf_role STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Role - DEFAULT = CURRENT_ROLE()'),
sf_database STRING(16777216) DEFAULT 'ldl' NOT NULL
OPTIONS(description='Snowflake Database - DEFAULT = CURRENT_DATABASE()'),
sf_schema STRING(16777216) DEFAULT 'p_lew_mart_pit' NOT NULL
OPTIONS(description='Snowflake Schema - DEFAULT = CURRENT_SCHEMA()'),
sf_session STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Session - DEFAULT = CURRENT_SESSION()'),
sf_client STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Client - DEFAULT = CURRENT_CLIENT()'),
record_processed_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Number of processed Records'),
start_processing_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator of the start of the loading run. [0|1]'),
end_processing_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator of the end of the loading run. [0|1]'),
module_level_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator level Module. [0|1]'),
component_level_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator level Component. [0|1]'),
completed_run_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator that loading run is completed. [0|1]'),
module_start_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator level Module. [0|1]'),
module_end_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator level Module. [0|1]'),
component_start_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator level Component. [0|1]'),
component_end_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator level Component. [0|1]'),
moving_run_id_from_current INTEGER DEFAULT 0
OPTIONS(description='[View] Current ID = 0 previous Run IDs are -1,-2,etc.'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (run_id_seq, run_day_id, deleted_fg) NOT ENFORCED
) OPTIONS(description='Central ETL Logging Table, holding the start and end timestamps, and the execution run time.');