/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_queue
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_queue (
	client_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 	VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
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
) COMMENT = 'SAP EWM - Queue for WM Monitor Output'
;