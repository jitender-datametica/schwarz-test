/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	Data
DB table/view	|	t_sapewm_ref_picking_queue
Description		|	SAP EWM QUEUE list - lookup for FE
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_ref_picking_queue (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client ID'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse ID'),
queue STRING(20) NOT NULL OPTIONS(description='Queue'),
perf_area STRING(50) OPTIONS(description='Performance area'),
perf_area_desc STRING(50) OPTIONS(description='Performance area description'),
dwh_sort INTEGER OPTIONS(description='DWH sorting number'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (client_id, wh_id, queue) NOT ENFORCED
) OPTIONS(description='SAP EWM - lookup for FE (PK client_id, wh_id, queue)');