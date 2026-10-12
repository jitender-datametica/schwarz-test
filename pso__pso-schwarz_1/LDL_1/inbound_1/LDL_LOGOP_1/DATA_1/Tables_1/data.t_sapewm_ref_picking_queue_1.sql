/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	Data
DB table/view	|	t_sapewm_ref_picking_queue_1
Description		|	SAP EWM QUEUE list - lookup for FE
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_ref_picking_queue_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client ID',
	wh_id NUMBER(5,0) NOT NULL COMMENT 'Warehouse ID',
	QUEUE VARCHAR(20) NOT NULL COMMENT 'Queue',
	perf_area VARCHAR(50) COMMENT 'Performance area',
	perf_area_desc VARCHAR(50) COMMENT 'Performance area description',
	dwh_sort NUMBER(3,0) COMMENT 'DWH sorting number',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation timestamp',
	dwh_src VARCHAR(50) COMMENT 'DWH source',
	PRIMARY KEY (client_id, wh_id, QUEUE)
 ) COMMENT='SAP EWM - lookup for FE (PK client_id, wh_id, queue)'
 ;