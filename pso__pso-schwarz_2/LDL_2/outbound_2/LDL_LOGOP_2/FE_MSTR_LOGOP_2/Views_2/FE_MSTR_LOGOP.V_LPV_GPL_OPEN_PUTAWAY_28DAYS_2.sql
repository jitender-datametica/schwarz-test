CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_gpl_open_putaway_28days_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), stock_id
OPTIONS(description='Surrogate key Original name: Bestandid'), src_pallet_nr
OPTIONS(description='Number of the pallet on which the stock is located. FK: References LPV.LHM.LHMNR and LPV.BEDSTAND.LHMNR. Original name - lhmnr'),
article_nr OPTIONS(description='Foreign Key. References LPV.AST.ANR.'), gr_date
OPTIONS(description='Good Receiving Date'), p3_gr_priority OPTIONS(description='Priority'), dwh_updated
OPTIONS(description='Indication when the data is loaded'), target_area_nr
OPTIONS(description='Target Area of Open Putaways'), fixbin_id
OPTIONS(description='Location_2 that is set as the picking location. Foreign Key. References LPV.WHX.ORT'), gang_nr
OPTIONS(description='Calculated from FIXBIN_ID - the first 2 digits of location_2 ID')) AS SELECT BE.client_id,
 BE.wh_id,
 BE.stock_id,
 BE.src_pallet_nr,
 BE.article_nr,
 BE.gr_date,
 BE.p3_gr_priority,
 BE.dwh_updated,
 IF(ASTB.fixbin_id IS NOT NULL, AREA.reserve_area_nr, IF(AST.v2_item_group IN (10, 11, 12, 13, 14, 30, 31, 32, 33, 35,
     36, 40, 42), 701, IF(AST.v2_item_group IN (20, 74), 702, IF(AST.v2_item_group IN (41, 43, 44, 45, 46, 47, 48, 49,
       50, 51, 52, 54, 60, 61, 62, 63, 70, 71, 72, 73, 77, 80, 81, 82, 83, 84, 85, 86), 700, IF(AST.v2_item_group IN (90
        , 91, 92), 0, IF(AST.v2_item_group > 100, 706, 0)))))) AS target_area_nr,
 ASTB.fixbin_id,
 CONCAT('Aisle', ' ', SUBSTR(ASTB.fixbin_id, 1, 2)) AS gang_nr
FROM ldl_logop_data.t_lpv_bestand_2 AS BE
 LEFT JOIN ldl_logop_data.t_lpv_astber_2 AS ASTB ON BE.client_id = ASTB.client_id AND BE.wh_id = ASTB.wh_id AND BE.article_nr
      = ASTB.article_nr AND CURRENT_DATE BETWEEN ASTB.dwh_valid_from AND ASTB.dwh_valid_to AND NOT ASTB.deleted_fg
 LEFT JOIN ldl_logop_data.t_lpv_whx_2 AS W ON ASTB.client_id = W.client_id AND ASTB.wh_id = W.wh_id AND ASTB.fixbin_id = W
     .location_id AND CURRENT_DATE BETWEEN W.dwh_valid_from AND W.dwh_valid_to AND NOT W.deleted_fg
 LEFT JOIN ldl_logop_data.t_lpv_area_2 AS AREA ON W.client_id = AREA.client_id AND W.wh_id = AREA.wh_id AND W.area_nr =
     AREA.area_nr AND CURRENT_DATE BETWEEN AREA.dwh_valid_from AND AREA.dwh_valid_to AND NOT AREA.deleted_fg
 LEFT JOIN ldl_logop_data.t_lpv_area_2 AS RES ON AREA.client_id = RES.client_id AND AREA.wh_id = RES.wh_id AND AREA.reserve_area_nr
       = RES.area_nr AND RES.area_nr BETWEEN 700 AND 899 AND CURRENT_DATE BETWEEN RES.dwh_valid_from AND RES.dwh_valid_to
     AND NOT RES.deleted_fg
 LEFT JOIN ldl_logop_data.t_lpv_ast_2 AS AST ON BE.client_id = AST.client_id AND BE.wh_id = AST.wh_id AND BE.article_nr =
     AST.article_nr AND CURRENT_DATE BETWEEN AST.dwh_valid_from AND AST.dwh_valid_to AND NOT AST.deleted_fg
WHERE BE.src_area_nr = 1000
 AND CURRENT_DATE BETWEEN BE.dwh_valid_from AND BE.dwh_valid_to
 AND BE.gr_date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 28 DAY) AND (CURRENT_DATE)
 AND NOT BE.deleted_fg;