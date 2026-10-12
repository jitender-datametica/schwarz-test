/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_gpl_open_replenishment
Description		|	LPV Gruppenleiter - supplementary View to calculate open replenishments
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_GPL_OPEN_REPLENISHMENT(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	AUFTRAG COMMENT 'Task number. Original name - auftrag',
	TANR COMMENT 'Task number in WAMAS. Original name - tanr',
	STATUS COMMENT 'Task status. Original name - status',
	TYP COMMENT 'Task type. Original name - typ',
	ARTIKELNR COMMENT 'Item number. FK: References LPV.AST.ANR. Original name - artikelnr',
	AREA_NR COMMENT 'Area of Open Replenishment',
	FIXBIN_ID COMMENT 'Location that is set as the picking location. Foreign Key. References LPV.WHX.ORT',
	GANG_NR COMMENT 'Calculated from FIXBIN_ID - the first 2 digits of location ID',
	PRIO COMMENT 'Priority',
	OP_DT COMMENT 'Operation Date',
	DWH_UPDATED COMMENT 'Indication when the table got updated'
) COMMENT='This is a View for LPV GPL to calculate the Open Replenishment'
 AS
SELECT 
	wms.client_id
   ,wms.wh_id
   ,wms.auftrag
   ,wms.tanr
   ,wms.status
   ,wms.typ
   ,wms.artikelnr
   ,IFF(astb.fixbin_id IS NOT NULL,astb.area_nr
   ,IFF(ast.v2_item_group IN (10,11,12,13,14,30,31,32,33,35,36,40,42),2
   ,IFF(ast.v2_item_group IN (20,74),3
   ,IFF(ast.v2_item_group IN (41,43,44,45,46,47,48,49,50,51,52,54,60,61,62,63,70,71,72,73,77,80,81,82,83,84,85,86),1
   ,IFF(ast.v2_item_group IN (90,91,92),0
   ,IFF(ast.v2_item_group >100,6,0)))))) AS area_nr
   ,astb.fixbin_id
   ,CONCAT('Aisle',' ',SUBSTRING(astb.fixbin_id,1,2)) AS gang_nr
   ,wms.prio
   ,TO_DATE(wms.anlagezeit) AS op_dt
   ,wms.dwh_updated
FROM "DATA".T_LPV_WMS_WAMAS_PROD wms
LEFT JOIN "DATA".T_LPV_ASTBER astb
ON wms.client_id = astb.client_id
AND wms.wh_id = astb.wh_id
AND wms.artikelnr = astb.article_nr
AND CURRENT_DATE BETWEEN astb.dwh_valid_from AND astb.dwh_valid_to
AND astb.deleted_fg = FALSE
LEFT JOIN "DATA".T_LPV_AREA area
ON astb.client_id = area.client_id 
AND astb.wh_id = area.wh_id 
AND astb.area_nr = area.area_nr
AND CURRENT_DATE BETWEEN area.dwh_valid_from AND area.dwh_valid_to
AND area.deleted_fg = FALSE
LEFT JOIN "DATA".T_LPV_AST ast
ON wms.client_id = ast.client_id
AND wms.wh_id = ast.wh_id
AND wms.artikelnr = ast.article_nr
AND CURRENT_DATE BETWEEN ast.dwh_valid_from AND ast.dwh_valid_to
AND ast.deleted_fg = FALSE
WHERE wms.typ = 'NACH'
AND CURRENT_DATE BETWEEN wms.dwh_valid_from AND wms.dwh_valid_to
AND wms.deleted_fg = FALSE
AND TO_DATE(wms.anlagezeit) BETWEEN CURRENT_DATE-28 AND CURRENT_DATE
;