/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_countinglog_temp_1
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_sapewm_countinglog_temp_1 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id					NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	mandt					VARCHAR(3)		NULL 	 	COMMENT 'Client',
	lgnum                   VARCHAR(4)      NOT NULL 	COMMENT 'Warehouse Number/Warehouse Complex',
	finish_tstamp           TIMESTAMP	    NOT NULL 	COMMENT 'Time of Confirmation',
	uname                   VARCHAR(12)     NOT NULL 	COMMENT 'ABAP System Field: Name of Current User',
	door                    VARCHAR(4)      NOT NULL 	COMMENT 'Warehouse Door',
	lane                    VARCHAR(18)     NOT NULL 	COMMENT 'Storage Bin',
	start_tstamp            TIMESTAMP	    NULL 	 	COMMENT 'Start Time',
	tu_num                  VARCHAR(18)     NULL 	 	COMMENT 'Internal Number of Transportation Unit_1',
	tu_sr_act_num           NUMBER(38,0)    NULL 	 	COMMENT 'Shipping and Receiving Activity Number: Transportation Unit_1',
	count_hu                NUMBER(38,0)    NULL 	 	COMMENT '2 Byte Signed Integer',
	dwh_load_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	PRIMARY KEY (client_id, lgnum, finish_tstamp, uname, door, lane)
) COMMENT = 'SAP EWM - Internal counting log for warehouse performance (R338)'
;