/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_queue_temp_1
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_sapewm_queue_temp_1 (
	client_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 	VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 	VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id			NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum			VARCHAR(5)		NOT NULL	COMMENT 'Warehouse Number/Warehouse Complex',
	QUEUE			VARCHAR(10)     NOT NULL    COMMENT 'Queue',
	rfrsrc			VARCHAR(1)		NULL        COMMENT 'Operating Environment',
	tot_who			NUMBER(38,0)    NULL        COMMENT 'Total Number of Open Warehouse Orders',
	tot_rsrc		NUMBER(38,0)    NULL        COMMENT 'Number of Active Resources per Queue',
	text_descr		VARCHAR(40)     NULL        COMMENT 'Description',
	dwh_load_id 	NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	PRIMARY KEY (client_id, lgnum, QUEUE)
) COMMENT = 'SAP EWM - Queue for WM_1 Monitor Output'
;