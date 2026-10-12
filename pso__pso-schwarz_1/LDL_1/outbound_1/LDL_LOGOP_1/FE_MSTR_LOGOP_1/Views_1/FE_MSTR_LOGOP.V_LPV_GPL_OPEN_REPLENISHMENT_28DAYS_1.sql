CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_gpl_open_replenishment_28days_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), auftrag
OPTIONS(description='Task number. Original name - auftrag'), tanr
OPTIONS(description='Task number in WAMAS. Original name - tanr'), status_1
OPTIONS(description='Task status. Original name - status_1'), typ OPTIONS(description='Task type. Original name - typ'),
artikelnr OPTIONS(description='Item_1 number. FK: References LPV.AST.ANR. Original name - artikelnr'), area_nr
OPTIONS(description='Area of Open Replenishment'), fixbin_id
OPTIONS(description='Location_1 that is set as the picking location. Foreign Key. References LPV.WHX.ORT'), gang_nr
OPTIONS(description='Calculated from FIXBIN_ID - the first 2 digits of location_1 ID'), prio
OPTIONS(description='Priority'), op_dt OPTIONS(description='Operation Date'), dwh_updated
OPTIONS(description='Indication when the table got updated')) AS SELECT WMS.client_id,
 WMS.wh_id,
 WMS.auftrag,
 WMS.tanr,
 WMS.status_1,
 WMS.typ,
 WMS.artikelnr,
 IF(ASTB.fixbin_id IS NOT NULL, ASTB.area_nr, IF(AST.v2_item_group IN (10, 11, 12, 13, 14, 30, 31, 32, 33, 35, 36, 40,
     42), 2, IF(AST.v2_item_group IN (20, 74), 3, IF(AST.v2_item_group IN (41, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52,
       54, 60, 61, 62, 63, 70, 71, 72, 73, 77, 80, 81, 82, 83, 84, 85, 86), 1, IF(AST.v2_item_group IN (90, 91, 92), 0,
      IF(AST.v2_item_group > 100, 6, 0)))))) AS area_nr,
 ASTB.fixbin_id,
 CONCAT('Aisle', ' ', SUBSTR(ASTB.fixbin_id, 1, 2)) AS gang_nr,
 WMS.prio,
 DATE(WMS.anlagezeit) AS op_dt,
 WMS.dwh_updated
FROM ldl_logop_data.t_lpv_wms_wamas_prod_1 AS WMS
 LEFT JOIN ldl_logop_data.t_lpv_astber_1 AS ASTB ON WMS.client_id = ASTB.client_id AND WMS.wh_id = ASTB.wh_id AND WMS.artikelnr
      = ASTB.article_nr AND CURRENT_DATE BETWEEN ASTB.dwh_valid_from AND ASTB.dwh_valid_to AND NOT ASTB.deleted_fg
 LEFT JOIN ldl_logop_data.t_lpv_area_1 AS AREA ON ASTB.client_id = AREA.client_id AND ASTB.wh_id = AREA.wh_id AND ASTB.area_nr
      = AREA.area_nr AND CURRENT_DATE BETWEEN AREA.dwh_valid_from AND AREA.dwh_valid_to AND NOT AREA.deleted_fg
 LEFT JOIN ldl_logop_data.t_lpv_ast_1 AS AST ON WMS.client_id = AST.client_id AND WMS.wh_id = AST.wh_id AND WMS.artikelnr
     = AST.article_nr AND CURRENT_DATE BETWEEN AST.dwh_valid_from AND AST.dwh_valid_to AND NOT AST.deleted_fg
WHERE WMS.typ = 'NACH'
 AND CURRENT_DATE BETWEEN WMS.dwh_valid_from AND WMS.dwh_valid_to
 AND DATE(WMS.anlagezeit) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 28 DAY) AND (CURRENT_DATE)
 AND NOT WMS.deleted_fg;