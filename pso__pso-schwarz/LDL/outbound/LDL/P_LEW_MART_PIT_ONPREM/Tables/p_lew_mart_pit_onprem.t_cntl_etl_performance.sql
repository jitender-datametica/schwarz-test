CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_cntl_etl_performance (
run_id_seq BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Fortlaufende Nummer der ETL-Verarbeitung - basierend auf SEQ_T_CNTL_ETL_PERFORMANCE (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)'),
run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Ausführungs Zeitstempel. Beginn der täglichen ETL-Verarbeitung (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)'),
run_day_id DATE DEFAULT CAST('8888-12-31' AS DATE) NOT NULL
OPTIONS(description='Ausführungstag. Format YYYY-MM-DD (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)'),
run_clustering_desc STRING(250) DEFAULT '[0]' NOT NULL
OPTIONS(description='Ausführungscluster im Falle einer paralleln Ausführung. Format [ Clustername ]. (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)'),
application_name STRING(250) DEFAULT 'n/A' NOT NULL
OPTIONS(description='Genereller Name der Applikation (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ) Name of Application --> Module --> Component'),
module_name STRING(250) DEFAULT 'n/A' NOT NULL
OPTIONS(description='Name des Programmmodules. Beispiel: POS-Kassendaten-Verarbeitung. Module Name --> Component.'),
component_name STRING(250) DEFAULT 'n/A' NOT NULL
OPTIONS(description='Name der Programm-Component eines Programm Modules. Beispiel: POS-ReceiptLine Verarbeitung'),
start_run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Start Zeitstempl der Verarbeitung'),
end_run_ts DATETIME OPTIONS(description='Ende zeitstemple der Verarbeitung'),
run_time_min BIGNUMERIC(38,0) OPTIONS(description='[VC] Ausführungszeit in Minuten'),
run_time_sec BIGNUMERIC(38,0) OPTIONS(description='[VC] Ausführungszeit in Sekunden'),
project_query_tag STRING(16777216) OPTIONS(description='Quertag'),
project_sf_user STRING(150) DEFAULT 'SESSION_USER()' NOT NULL
OPTIONS(description='Snowflake User - Default =  SESSION_USER()'),
project_sf_warehouse STRING(150) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Warehouse - Default = N/A'),
project_sf_role STRING(150) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Role - Default = N/A'),
project_sf_database STRING(150) DEFAULT 'ldl' NOT NULL
OPTIONS(description='Snowflake Database - Default = ldl'),
project_sf_schema STRING(150) DEFAULT 'p_lew_mart_pit_onprem' NOT NULL
OPTIONS(description='Snowflake Schema - Default = p_lew_mart_pit_onprem'),
project_sf_session STRING(150) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Session - Default = N/A'),
project_sf_client STRING(150) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Snowflake Client - Default = N/A'),
record_processed_nr BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Number of processed Records'),
run_ldesc STRING(16777216)
OPTIONS(description='[VC] Description des Auführungslaufes. Beispiel:\'ETL RUn 10 on Thursday 2021-JUL-26 15:37:04.6789\' '),
start_processig_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flagge / Indikator des Start des Ladelauf. [0|1]'),
end_processig_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flagge / Indikator des Startes des Ladelaufes. [0|1]'),
module_level_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Flagge / Indikator Ebene Module. [0|1]'),
component_level_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flagge / Indikator Ebene Componente. [0|1]'),
completed_run_flag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flagge / Indikator das Ladelauf abgeschlossen ist. [0|1]'),
moving_run_id_from_current BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='[View] Current ID = 0 previous Run IDs are -1,-2,etc.'),
query_id STRING(150) OPTIONS(description='The statement’s UNIQUE id.'),
query_text STRING(16777216) OPTIONS(description='Text of the SQL statement.'),
database_name STRING(150) OPTIONS(description='Database that was in use at the time of the query.'),
schema_name STRING(150) OPTIONS(description='Schema that was in use at the time of the query.'),
query_type STRING(150)
OPTIONS(description='DML, query, etc. If the query is currently running, or the query failed, then the query type may be UNKNOWN.'),
session_id BIGNUMERIC(38,0) OPTIONS(description='Session that executed the statement.'),
user_name STRING(150) OPTIONS(description='User who issued the query.'),
role_name STRING(150) OPTIONS(description='Role that was active in the session at the time of the query.'),
warehouse_name STRING(150) OPTIONS(description='Warehouse that the query executed on, if any.'),
warehouse_size STRING(150) OPTIONS(description='Size of the warehouse when this statement executed.'),
warehouse_type STRING(150) OPTIONS(description='Type of the warehouse when this statement executed.'),
cluster_number BIGNUMERIC(38,0)
OPTIONS(description='The cluster (in a multi-cluster warehouse) that this statement executed on.'),
query_tag STRING(250) OPTIONS(description='Query tag set for this statement through the QUERY_TAG session parameter.'),
execution_status STRING(150)
OPTIONS(description='Execution status for the query: resuming_warehouse, running, queued, blocked, success, failed_with_error, or failed_with_incident.'),
error_code BIGNUMERIC(38,0) OPTIONS(description='Error code, if the query returned an error'),
error_message STRING(16777216) OPTIONS(description='Error message, if the query returned an error'),
start_time DATETIME OPTIONS(description='Statement start time'),
end_time DATETIME
OPTIONS(description='Statement end time. If the query is still running, the END_TIME is the UNIX epoch timestamp (“1970-01-01 00:00:00”), adjusted for the local time zone. E.g. for Pacific Standard Time, this would be “1969-12-31 16:00:00.000 -0800”.'),
total_elapsed_time BIGNUMERIC(38,0) OPTIONS(description='Elapsed time (in milliseconds)'),
sql_run_time_min BIGNUMERIC(38,0)
OPTIONS(description='SQL Ausführungszeit in Minuten. Level SQL. Could be used for Summation.'),
sql_run_time_sec BIGNUMERIC(38,0)
OPTIONS(description='SQL Ausführungszeit in Sekunden. Level SQL. Could be used for Summation.'),
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
outbound_data_transfer_cloud STRING(150)
OPTIONS(description='Target cloud provider for statements that unload data to another region and/or cloud.'),
outbound_data_transfer_region STRING(150)
OPTIONS(description='Target region for statements that unload data to another region and/or cloud.'),
outbound_data_transfer_bytes BIGNUMERIC(38,0)
OPTIONS(description='Number of bytes transferred in statements that unload data to another region and/or cloud.'),
inbound_data_transfer_cloud STRING(150)
OPTIONS(description='Source cloud provider for statements that load data from another region and/or cloud.'),
inbound_data_transfer_region STRING(150)
OPTIONS(description='Source region for statements that load data from another region and/or cloud.'),
inbound_data_transfer_bytes BIGNUMERIC(38,0)
OPTIONS(description='Number of bytes transferred in statements that load data from another region and/or cloud.'),
list_external_file_time BIGNUMERIC(38,0) OPTIONS(description='Time (in milliseconds) spent listing external files.'),
credits_used_cloud_services FLOAT64 OPTIONS(description='Number of credits used for cloud services in the hour.'),
release_version STRING(150)
OPTIONS(description='Release version in the format of major_release.minor_release.patch_release.'),
external_function_total_invocations BIGNUMERIC(38,0)
OPTIONS(description='The aggregate number of times that this query called remote services. For important details, see the Usage Notes.'),
external_function_total_sent_rows BIGNUMERIC(38,0)
OPTIONS(description='The total number of rows that this query sent in all calls to all remote services.'),
external_function_total_received_rows BIGNUMERIC(38,0)
OPTIONS(description='The total number of rows that this query received from all calls to all remote services.'),
external_function_total_sent_bytes BIGNUMERIC(38,0)
OPTIONS(description='The total number of bytes that this query sent in all calls to all remote services.'),
external_function_total_received_bytes BIGNUMERIC(38,0)
OPTIONS(description='The total number of bytes that this query received from all calls to all remote services.'),
deleted_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / AB>Initio Process ID'),
PRIMARY KEY (run_id_seq, run_day_id, deleted_fg) NOT ENFORCED
) OPTIONS(description='Kontroltablle zu ETL-Performance');