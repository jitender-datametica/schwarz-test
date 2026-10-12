/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_area_filter
Description		|	SAP EWM Area Filter
====================================================================================================
*/


CREATE OR REPlACE VIEW FE_MSTR_LOGOP.V_SAPEWM_GPL_AREA_FILTER_1(
	DEST_STRG_TYPE COMMENT 'Destination Storage Type',
	QUEUE COMMENT 'Queue',
	AREA_COMB COMMENT 'Warehouse Area'
) AS
SELECT 
    IFNULL(dest_strg_type,'unknown') AS dest_strg_type,
	IFNULL(QUEUE,'unknown') AS QUEUE,
    area_comb
FROM "DATA".T_SAPEWM_GPL_FILTER_1;