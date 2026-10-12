/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_scwmqseq_temp_2
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_sapewm_scwmqseq_temp_2 (
	client_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	lidl_country 	VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila', 
	source_system 	VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id			NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	mandt			VARCHAR(3)		NULL		COMMENT 'Client',
	lgnum           VARCHAR(5)      NULL    	COMMENT 'Warehouse Number/Warehouse Complex',
	rsrc_grp        VARCHAR(4)      NULL    	COMMENT 'Resource Group',
	seqno           NUMBER(38,0)    NULL    	COMMENT 'Sequence Number',
	QUEUE           VARCHAR(10)     NULL        COMMENT 'Queue',
	nointerleav     BOOLEAN         NULL        COMMENT 'No Interleaving in RF',
	zz_crssys       BOOLEAN         NULL        COMMENT 'Cross System Guided',
	dwh_load_id 	NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at'
) COMMENT = 'SAP EWM - Sequenced Queues Per Resource Group'
;