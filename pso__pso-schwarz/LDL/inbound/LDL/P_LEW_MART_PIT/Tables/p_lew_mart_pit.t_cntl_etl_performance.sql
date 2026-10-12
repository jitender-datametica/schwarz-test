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

CREATE TABLE P_LEW_MART_PIT.T_CNTL_ETL_PERFORMANCE (
	RUN_ID_SEQ									INTEGER				NOT NULL 	DEFAULT -1 									COMMENT 'Fortlaufende Nummer der ETL-Verarbeitung - basierend auf SEQ_T_CNTL_ETL_PERFORMANCE (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)',
	RUN_TS										TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Ausführungs Zeitstempel. Beginn der täglichen ETL-Verarbeitung (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)',
	RUN_DAY_ID									DATE				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Ausführungstag. Format YYYY-MM-DD (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)',
				
	-- in case of parallel ExecutionClusters of same application
	-- this will keep the clustering(partition by) key
	RUN_CLUSTERING_DESC							VARCHAR				NOT NULL 	DEFAULT '[0]' 								COMMENT 'Ausführungscluster im Falle einer paralleln Ausführung. Format [ Clustername ]. (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ)',
				
	-- executed client Id(s) -1 ::=All clients
	CLIENT_ID 									INTEGER		 		NOT NULL 	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',	
			
	-- executed client Id(s)			
 	MULTI_CLIENT_RUN_LST						ARRAY																		COMMENT 'Executed Client ID(s) in case of multiple Client IDs will be executed',
	-- Name of Application --> Module --> Component
	APPLICATION_NAME							VARCHAR				NOT NULL 	DEFAULT 'n/A' 								COMMENT 'Genereller Name der Applikation (siehe T_CNTL_ETL_PERFORMANCE_RUN_SEQ) Name of Application --> Module --> Component',
	-- Module NAME --> Component			
	MODULE_NAME									VARCHAR				NOT NULL 	DEFAULT 'n/A' 								COMMENT 'Name des Programmmodules. Beispiel: POS-Kassendaten-Verarbeitung. Module Name --> Component.',
	-- Component NAME OF Module				
	COMPONENT_NAME								VARCHAR				NOT NULL 	DEFAULT 'n/A' 								COMMENT 'Name der Programm-Component eines Programm Modules. Beispiel: POS-ReceiptLine Verarbeitung',
	START_RUN_TS								TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Start Zeitstempl der Verarbeitung',
	END_RUN_TS									TIMESTAMP		 															COMMENT 'Ende zeitstemple der Verarbeitung',
	RUN_TIME_MIN								NUMBER(38,0) 																COMMENT '[VC] Ausführungszeit in Minuten',
	RUN_TIME_SEC								NUMBER(38,0) 																COMMENT '[VC] Ausführungszeit in Sekunden',
												
	PROJECT_QUERY_TAG							VARCHAR 																	COMMENT 'Quertag',
						
	PROJECT_SF_USER								VARCHAR				NOT NULL 	DEFAULT CURRENT_USER() 						COMMENT 'Snowflake User - 	DEFAULT =  CURRENT_USER()',
	PROJECT_SF_WAREHOUSE						VARCHAR				NOT NULL 	DEFAULT CURRENT_WAREHOUSE() 				COMMENT 'Snowflake Warehouse - 	DEFAULT = CURRENT_WAREHOUSE()',
	PROJECT_SF_ROLE								VARCHAR				NOT NULL 	DEFAULT CURRENT_ROLE() 						COMMENT 'Snowflake Role - 	DEFAULT = CURRENT_ROLE()',
	PROJECT_SF_DATABASE							VARCHAR				NOT NULL 	DEFAULT CURRENT_DATABASE() 					COMMENT 'Snowflake Database - 	DEFAULT = CURRENT_DATABASE()',
	PROJECT_SF_SCHEMA							VARCHAR				NOT NULL 	DEFAULT CURRENT_SCHEMA() 					COMMENT 'Snowflake Schema - 	DEFAULT = CURRENT_SCHEMA()',
	PROJECT_SF_SESSION							VARCHAR				NOT NULL 	DEFAULT CURRENT_SESSION() 					COMMENT 'Snowflake Session - 	DEFAULT = CURRENT_SESSION()',
	PROJECT_SF_CLIENT							VARCHAR				NOT NULL 	DEFAULT CURRENT_CLIENT() 					COMMENT 'Snowflake Client - 	DEFAULT = CURRENT_CLIENT()',
				
	RECORD_PROCESSED_NR							INTEGER				NOT NULL 	DEFAULT 0 									COMMENT 'Number of processed Records',
	-- VIEW Columns				
	RUN_LDESC									VARCHAR 																	COMMENT '[VC] Description des Auführungslaufes. Beispiel: ''ETL RUn 10 on Thursday 2021-JUL-26 15:37:04.6789'' ',
	START_PROCESSING_FG							SMALLINT			NOT NULL 	DEFAULT 0 									COMMENT 'Flagge / Indikator des Start des Ladelauf. [0|1]',
	END_PROCESSING_FG							SMALLINT			NOT NULL 	DEFAULT 0 									COMMENT 'Flagge / Indikator des Startes des Ladelaufes. [0|1]',
	MODULE_LEVEL_FG								SMALLINT			NOT NULL 	DEFAULT 0 									COMMENT 'Flagge / Indikator Ebene Module. [0|1]',
	COMPONENT_LEVEL_FG							SMALLINT			NOT NULL 	DEFAULT 0 									COMMENT 'Flagge / Indikator Ebene Componente. [0|1]',
	COMPLETED_RUN_FG							SMALLINT			NOT NULL 	DEFAULT 0 									COMMENT 'Flagge / Indikator das Ladelauf abgeschlossen ist. [0|1]',
	MOVING_RUN_ID_FROM_CURRENT					INTEGER		 					DEFAULT 0 									COMMENT '[View] Current ID = 0 previous Run IDs are -1,-2,etc.',
	QUERY_ID									VARCHAR 																	COMMENT 'The statement’s unique id.',
	QUERY_TEXT									VARCHAR 																	COMMENT 'Text of the SQL statement.',
	DATABASE_NAME								VARCHAR 																	COMMENT 'Database that was in use at the time of the query.',
	SCHEMA_NAME									VARCHAR 																	COMMENT 'Schema that was in use at the time of the query.',
	QUERY_TYPE									VARCHAR 																	COMMENT 'DML, query, etc. If the query is currently running, or the query failed, then the query type may be UNKNOWN.',
	SESSION_ID									INTEGER		 																COMMENT 'Session that executed the statement.',
	USER_NAME									VARCHAR 																	COMMENT 'User who issued the query.',
	ROLE_NAME									VARCHAR 																	COMMENT 'Role that was active in the session at the time of the query.',
	WAREHOUSE_NAME								VARCHAR 																	COMMENT 'Warehouse that the query executed on, if any.',
	WAREHOUSE_SIZE								VARCHAR 																	COMMENT 'Size of the warehouse when this statement executed.',
	WAREHOUSE_TYPE								VARCHAR 																	COMMENT 'Type of the warehouse when this statement executed.',
	CLUSTER_NBR									INTEGER		 																COMMENT 'The cluster (in a multi-cluster warehouse) that this statement executed on.',
	QUERY_TAG									VARCHAR 																	COMMENT 'Query tag set for this statement through the QUERY_TAG session parameter.',
	EXECUTION_STATUS							VARCHAR 																	COMMENT 'Execution status for the query: resuming_warehouse, running, queued, blocked, success, failed_with_error, or failed_with_incident.',
	ERROR_CODE									NUMBER(38,0) 																COMMENT 'Error code, if the query returned an error',
	ERROR_MESSAGE								VARCHAR 																	COMMENT 'Error message, if the query returned an error',
	START_TIME									TIMESTAMP		 															COMMENT 'Statement start time',
	END_TIME									TIMESTAMP		 															COMMENT 'Statement end time. If the query is still running, the END_TIME is the UNIX epoch timestamp (“1970-01-01 00:00:00”), adjusted for the local time zone. E.g. for Pacific Standard Time, this would be “1969-12-31 16:00:00.000 -0800”.',
	TOTAL_ELAPSED_TIME							NUMBER(38,0) 																COMMENT 'Elapsed time (in milliseconds)',
	BYTES_SCANNED								NUMBER(38,0) 																COMMENT 'Number of bytes scanned by this statement.',
	ROWS_PRODUCED								NUMBER(38,0) 																COMMENT 'Number of rows produced by this statement.',
	COMPILATION_TIME							NUMBER(38,0) 																COMMENT 'Compilation time (in milliseconds)',
	EXECUTION_TIME								NUMBER(38,0) 																COMMENT 'Execution time (in milliseconds)',
	QUEUED_PROVISIONING_TIME					NUMBER(38,0) 																COMMENT 'Time (in milliseconds) spent in the warehouse queue, waiting for the warehouse compute resources to provision, due to warehouse creation, resume, or resize.',
	QUEUED_REPAIR_TIME							NUMBER(38,0) 																COMMENT 'Time (in milliseconds) spent in the warehouse queue, waiting for compute resources in the warehouse to be repaired.',
	QUEUED_OVERLOAD_TIME						NUMBER(38,0) 																COMMENT 'Time (in milliseconds) spent in the warehouse queue, due to the warehouse being overloaded by the current query workload.',
	TRANSACTION_BLOCKED_TIME					NUMBER(38,0) 																COMMENT 'Time (in milliseconds) spent blocked by a concurrent DML.',
	OUTBOUND_DATA_TRANSFER_CLOUD				VARCHAR 																	COMMENT 'Target cloud provider for statements that unload data to another region and/or cloud.',
	OUTBOUND_DATA_TRANSFER_REGION				VARCHAR 																	COMMENT 'Target region for statements that unload data to another region and/or cloud.',
	OUTBOUND_DATA_TRANSFER_BYTES				NUMBER(38,0) 																COMMENT 'Number of bytes transferred in statements that unload data to another region and/or cloud.',
	INBOUND_DATA_TRANSFER_CLOUD					VARCHAR 																	COMMENT 'Source cloud provider for statements that load data from another region and/or cloud.',
	INBOUND_DATA_TRANSFER_REGION				VARCHAR 																	COMMENT 'Source region for statements that load data from another region and/or cloud.',
	INBOUND_DATA_TRANSFER_BYTES					NUMBER(38,0) 																COMMENT 'Number of bytes transferred in statements that load data from another region and/or cloud.',
	LIST_EXTERNAL_FILE_TIME						NUMBER(38,0) 																COMMENT 'Time (in milliseconds) spent listing external files.',
	-- Credit used
	CREDITS_USED_CLOUD_SERVICES					NUMBER(38,5) 																COMMENT 'Number of credits used for cloud services in the hour.',
	RELEASE_VERSION								VARCHAR 																	COMMENT 'Release version in the format of major_release.minor_release.patch_release.',
	EXTERNAL_FUNCTION_TOTAL_INVOCATIONS			NUMBER(38,0) 																COMMENT 'The aggregate NUMBER of times that this query called remote services. For important details, see the Usage Notes.',
	EXTERNAL_FUNCTION_TOTAL_SENT_ROWS			NUMBER(38,0) 																COMMENT 'The total NUMBER of rows that this query sent in all calls to all remote services.',
	EXTERNAL_FUNCTION_TOTAL_RECEIVED_ROWS		NUMBER(38,0) 																COMMENT 'The total NUMBER of rows that this query received from all calls to all remote services.',
	EXTERNAL_FUNCTION_TOTAL_SENT_BYTES			NUMBER(38,0) 																COMMENT 'The total NUMBER of bytes that this query sent in all calls to all remote services.',
	EXTERNAL_FUNCTION_TOTAL_RECEIVED_BYTES		NUMBER(38,0) 																COMMENT 'The total NUMBER of bytes that this query received from all calls to all remote services.',
	DELETED_FG									SMALLINT			NOT NULL 	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS								TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS								TIMESTAMP		 															COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID										INTEGER				NOT NULL 	DEFAULT 0 									COMMENT 'Technical Field ELT / AB>Initio Process ID',
	PRIMARY KEY (RUN_ID_SEQ, RUN_DAY_ID, DELETED_FG)
)	COMMENT='Kontroltablle zu ETL-Performance'
;