/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_ewmps_readlazk_stage_1
Description		|	EWM PS stage table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_ewmps_readlazk_stage_1 (
runtime_ts DATETIME NOT NULL OPTIONS(description='Starting time of the job filling this table - extraction job runtime'),
record_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Record id - record number from AVRO file'),
extraction_ts DATETIME NOT NULL OPTIONS(description='Extraction timestamp'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
avro_seq_num BIGNUMERIC(38,0) OPTIONS(description='seq_num - float'),
avro_entry_seq_num BIGNUMERIC(38,0) OPTIONS(description='entry_seq_num - float'),
avro_mandt STRING(100) OPTIONS(description='Mandt - string'),
avro_lgnum STRING(100) OPTIONS(description='Lgnum - string'),
avro_lazid_laznr STRING(100) OPTIONS(description='Lazid_Laznr - string'),
avro_lazbez STRING(200) OPTIONS(description='Lazbez - string'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
PRIMARY KEY (runtime_ts, record_id, extraction_ts, source_system, lidl_country) NOT ENFORCED
) OPTIONS(description='SAP EWM stage table for interface: readlazk');