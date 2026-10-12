/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : View for CNTL_ETL_PERFORMANCE
#-------------------------------------------------------------------------------
# Describtion: Create Table for SF Performance Logging
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz	   Initial version
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
RUN_TIME_MIN ?
RUN_TIME_SEC ?
RUN_LDESC    ?
SQL_RUN_TIME_MIN
SQL_RUN_TIME_SEC
MULTI_CLIENT_RUN_LST_NR
MULTI_CLIENT_RUN_LST_DESCR
MULTI_CLIENT_RUN_FG

*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_etl_performance (
run_id_seq INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Fortlaufende Nummer der ETL-Verarbeitung - basierend auf SEQ_T_CNTL_ETL_PERFORMANCE (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)'),
run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Ausführungs Zeitstempel. Beginn der täglichen ETL-Verarbeitung (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)'),
run_day_id DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Ausführungstag. Format YYYY-MM-DD (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)'),
run_clustering_desc STRING(16777216) DEFAULT '[0]' NOT NULL
OPTIONS(description='Ausführungscluster im Falle einer paralleln Ausführung. Format [ Clustername ]. (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)'),
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
multi_client_run_lst ARRAY < STRING >OPTIONS(description='Executed Client ID(s) in case of multiple Client IDs will be executed'),
application_name STRING(16777216) DEFAULT 'n/A' NOT NULL
OPTIONS(description='Genereller Name der Applikation (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ) Name of Application --> Module --> Component'),
module_name STRING(16777216) DEFAULT 'n/A' NOT NULL
OPTIONS(description='Name des Programmmodules. Beispiel: POS-Kassendaten-Verarbeitung. Module Name --> Component.'),
component_name STRING(16777216) DEFAULT 'n/A' NOT NULL
OPTIONS(description='Name der Programm-Component eines Programm Modules. Beispiel: POS-ReceiptLine Verarbeitung'),
start_run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Start Zeitstempl der Verarbeitung'),
end_run_ts DATETIME OPTIONS(description='Ende zeitstemple der Verarbeitung'),
run_time_min BIGNUMERIC(38,0) OPTIONS(description='[VC] Ausführungszeit in Minuten'),
run_time_sec BIGNUMERIC(38,0) OPTIONS(description='[VC] Ausführungszeit in Sekunden'),
project_query_tag STRING(16777216) OPTIONS(description='Quertag'),
project_sf_user STRING(16777216) DEFAULT SESSION_USER() NOT NULL
OPTIONS(description='Snowflake User - 	DEFAULT =  CURRENT_USER()'),
project_sf_warehouse STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Warehouse - 	DEFAULT = CURRENT_WAREHOUSE()'),
project_sf_role STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Role - 	DEFAULT = CURRENT_ROLE()'),
project_sf_database STRING(16777216) DEFAULT 'ldl' NOT NULL
OPTIONS(description='Snowflake Database - 	DEFAULT = CURRENT_DATABASE()'),
project_sf_schema STRING(16777216) DEFAULT 'p_lew_mart_pit' NOT NULL
OPTIONS(description='Snowflake Schema - 	DEFAULT = CURRENT_SCHEMA()'),
project_sf_session STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Session - 	DEFAULT = CURRENT_SESSION()'),
project_sf_client STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Client - 	DEFAULT = CURRENT_CLIENT()'),
record_processed_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Number of processed Records'),
run_ldesc STRING(16777216)
OPTIONS(description='[VC] Description des Auführungslaufes. Beispiel:\'ETL RUn 10 on Thursday 2021-JUL-26 15:37:04.6789\' '),
start_processing_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flagge / Indikator des Start des Ladelauf. [0|1]'),
end_processing_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flagge / Indikator des Startes des Ladelaufes. [0|1]'),
module_level_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flagge / Indikator Ebene Module. [0|1]'),
component_level_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flagge / Indikator Ebene Componente. [0|1]'),
completed_run_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flagge / Indikator das Ladelauf abgeschlossen ist. [0|1]'),
moving_run_id_from_current INTEGER DEFAULT 0
OPTIONS(description='[View] Current ID = 0 previous Run IDs are -1,-2,etc.'),
query_id STRING(16777216) OPTIONS(description='The statement’s unique id.'),
query_text STRING(16777216) OPTIONS(description='Text of the SQL statement.'),
database_name STRING(16777216) OPTIONS(description='Database that was in use at the time of the query.'),
schema_name STRING(16777216) OPTIONS(description='Schema that was in use at the time of the query.'),
query_type STRING(16777216)
OPTIONS(description='DML, query, etc. If the query is currently running, or the query failed, then the query type may be UNKNOWN.'),
session_id INTEGER OPTIONS(description='Session that executed the statement.'),
user_name STRING(16777216) OPTIONS(description='User who issued the query.'),
role_name STRING(16777216) OPTIONS(description='Role that was active in the session at the time of the query.'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse that the query executed on, if any.'),
warehouse_size STRING(16777216) OPTIONS(description='Size of the warehouse when this statement executed.'),
warehouse_type STRING(16777216) OPTIONS(description='Type of the warehouse when this statement executed.'),
cluster_nbr INTEGER OPTIONS(description='The cluster (in a multi-cluster warehouse) that this statement executed on.'),
query_tag STRING(16777216)
OPTIONS(description='Query tag set for this statement through the QUERY_TAG session parameter.'),
execution_status STRING(16777216)
OPTIONS(description='Execution status for the query: resuming_warehouse, running, queued, blocked, success, failed_with_error, or failed_with_incident.'),
error_code BIGNUMERIC(38,0) OPTIONS(description='Error code, if the query returned an error'),
error_message STRING(16777216) OPTIONS(description='Error message, if the query returned an error'),
start_time DATETIME OPTIONS(description='Statement start time'),
end_time DATETIME
OPTIONS(description='Statement end time. If the query is still running, the END_TIME is the UNIX epoch timestamp (“1970-01-01 00:00:00”), adjusted for the local time zone. E.g. for Pacific Standard Time, this would be “1969-12-31 16:00:00.000 -0800”.'),
total_elapsed_time BIGNUMERIC(38,0) OPTIONS(description='Elapsed time (in milliseconds)'),
bytes_scanned BIGNUMERIC(38,0) OPTIONS(description='Number of bytes scanned by this statement.'),
rows_produced BIGNUMERIC(38,0) OPTIONS(description='Number of rows produced by this statement.'),
compilation_time BIGNUMERIC(38,0) OPTIONS(description='Compilation time (in milliseconds)'),
execution_time BIGNUMERIC(38,0) OPTIONS(description='Execution time (in milliseconds)'),
queued_provisioning_time BIGNUMERIC(38,0)
OPTIONS(description='Time (in milliseconds) spent in the warehouse queue, waiting for the warehouse compute resources to provision, due to warehouse creation, resume, or resize.'),
queued_repair_time BIGNUMERIC(38,0)
OPTIONS(description='Time (in milliseconds) spent in the warehouse queue, waiting for compute resources in the warehouse to be repaired.'),
queued_overload_time BIGNUMERIC(38,0)
OPTIONS(description='Time (in milliseconds) spent in the warehouse queue, due to the warehouse being overloaded by the current query workload.'),
transaction_blocked_time BIGNUMERIC(38,0)
OPTIONS(description='Time (in milliseconds) spent blocked by a concurrent DML.'),
outbound_data_transfer_cloud STRING(16777216)
OPTIONS(description='Target cloud provider for statements that unload data to another region and/or cloud.'),
outbound_data_transfer_region STRING(16777216)
OPTIONS(description='Target region for statements that unload data to another region and/or cloud.'),
outbound_data_transfer_bytes BIGNUMERIC(38,0)
OPTIONS(description='Number of bytes transferred in statements that unload data to another region and/or cloud.'),
inbound_data_transfer_cloud STRING(16777216)
OPTIONS(description='Source cloud provider for statements that load data from another region and/or cloud.'),
inbound_data_transfer_region STRING(16777216)
OPTIONS(description='Source region for statements that load data from another region and/or cloud.'),
inbound_data_transfer_bytes BIGNUMERIC(38,0)
OPTIONS(description='Number of bytes transferred in statements that load data from another region and/or cloud.'),
list_external_file_time BIGNUMERIC(38,0) OPTIONS(description='Time (in milliseconds) spent listing external files.'),
credits_used_cloud_services BIGNUMERIC(38,5)
OPTIONS(description='Number of credits used for cloud services in the hour.'),
release_version STRING(16777216)
OPTIONS(description='Release version in the format of major_release.minor_release.patch_release.'),
external_function_total_invocations BIGNUMERIC(38,0)
OPTIONS(description='The aggregate NUMBER of times that this query called remote services. For important details, see the Usage Notes.'),
external_function_total_sent_rows BIGNUMERIC(38,0)
OPTIONS(description='The total NUMBER of rows that this query sent in all calls to all remote services.'),
external_function_total_received_rows BIGNUMERIC(38,0)
OPTIONS(description='The total NUMBER of rows that this query received from all calls to all remote services.'),
external_function_total_sent_bytes BIGNUMERIC(38,0)
OPTIONS(description='The total NUMBER of bytes that this query sent in all calls to all remote services.'),
external_function_total_received_bytes BIGNUMERIC(38,0)
OPTIONS(description='The total NUMBER of bytes that this query received from all calls to all remote services.'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / AB>Initio Process ID'),
PRIMARY KEY (run_id_seq, run_day_id, deleted_fg) NOT ENFORCED
) OPTIONS(description='Kontroltablle zu ETL-Performance');