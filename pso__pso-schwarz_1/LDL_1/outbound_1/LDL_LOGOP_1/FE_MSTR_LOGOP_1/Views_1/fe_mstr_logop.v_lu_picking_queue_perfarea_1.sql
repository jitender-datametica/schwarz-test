/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lu_picking_queue_perfarea_1
Description		|	SAP EWM Pick Rate - lookup view with performance area
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_picking_queue_perfarea_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number'), wh_nr
OPTIONS(description='Warehouse Number/Warehouse Complex. Source column name: LGNUM'), queue OPTIONS(description='QUEUE'),
perf_area OPTIONS(description='Performance area'), perf_area_desc
OPTIONS(description='Description. Source column name: TEXT_DESCR'), dwh_created OPTIONS(description='Record created at'),
dwh_updated OPTIONS(description='Record updated at')) OPTIONS(DESCRIPTION = `QUEUE - VIEW BASED ON T_SAPEWM_QUEUE_1`) AS
SELECT Q.client_id,
 Q.wh_id,
 Q.lgnum AS wh_nr,
 Q.queue,
 P.perf_area,
 P.perf_area_desc,
 Q.dwh_created,
 Q.dwh_updated
FROM ldl_logop_data.t_sapewm_queue_1 AS Q
 INNER JOIN ldl_logop_data.t_sapewm_ref_picking_queue_1 AS P ON Q.client_id = P.client_id AND Q.queue = P.queue AND Q.wh_id
    = P.wh_id;