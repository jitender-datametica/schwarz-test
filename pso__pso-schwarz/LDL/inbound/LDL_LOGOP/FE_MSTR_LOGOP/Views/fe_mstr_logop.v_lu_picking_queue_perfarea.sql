/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lu_picking_queue_perfarea
Description		|	SAP EWM Pick Rate - lookup view with performance area
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_picking_queue_perfarea (
	client_id COMMENT 'Client id - calculated based on the country code',
	wh_id COMMENT 'Warehouse ID. Subset of Warehouse Number',
	wh_nr COMMENT 'Warehouse Number/Warehouse Complex. Source column name: LGNUM',
	QUEUE COMMENT 'QUEUE',
	perf_area COMMENT 'Performance area',
	perf_area_desc COMMENT 'Description. Source column name: TEXT_DESCR',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at'
) COMMENT='QUEUE - view based on t_sapewm_queue'
 AS
SELECT 
	q.client_id
	, q.wh_id
	, q.lgnum AS wh_nr
	, q.QUEUE
	, p.perf_area
	, p.perf_area_desc
	, q.dwh_created
	, q.dwh_updated
FROM  DATA.t_sapewm_queue q -- PK (client_id, wh_nr, QUEUE) 
 JOIN  DATA.t_sapewm_ref_picking_queue p -- PK (PK client_id, wh_id, QUEUE)
 	ON q.client_id = p.client_id 
 		AND q.QUEUE = p.QUEUE
	 		AND q.wh_id = p.wh_id
;

