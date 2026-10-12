/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_area_filter
Description		|	SAP EWM Area Filter
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_gpl_area_filter (dest_strg_type
OPTIONS(description='Destination Storage Type'), queue OPTIONS(description='Queue'), area_comb
OPTIONS(description='Warehouse Area')) AS SELECT IFNULL(dest_strg_type, 'unknown') AS dest_strg_type,
 IFNULL(queue, 'unknown') AS queue,
 area_comb
FROM ldl_logop_data.t_sapewm_gpl_filter;