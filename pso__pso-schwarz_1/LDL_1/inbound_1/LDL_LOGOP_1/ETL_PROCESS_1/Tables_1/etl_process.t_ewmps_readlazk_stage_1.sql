/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_ewmps_readlazk_stage_1
Description		|	EWM PS stage table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_ewmps_readlazk_stage_1 (
runtime_ts 			TIMESTAMP 		NOT NULL 	COMMENT 'Starting time of the job filling this table - extraction job runtime',
record_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Record id - record number from AVRO file',
extraction_ts 		TIMESTAMP 		NOT NULL 	COMMENT 'Extraction timestamp',
source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila',
avro_seq_num 		NUMBER(38,0) 	NULL 		COMMENT 'seq_num - float',
avro_entry_seq_num 	NUMBER(38,0) 	NULL 		COMMENT 'entry_seq_num - float',
avro_mandt 			VARCHAR(100) 	NULL 		COMMENT 'Mandt - string',
avro_lgnum 			VARCHAR(100) 	NULL 		COMMENT 'Lgnum - string',
avro_lazid_laznr 	VARCHAR(100) 	NULL 		COMMENT 'Lazid_Laznr - string',
avro_lazbez 		VARCHAR(200) 	NULL 		COMMENT 'Lazbez - string',
dwh_created 		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
PRIMARY KEY (runtime_ts, record_id, extraction_ts, source_system, lidl_country)
) COMMENT = 'SAP EWM stage table for interface: readlazk';