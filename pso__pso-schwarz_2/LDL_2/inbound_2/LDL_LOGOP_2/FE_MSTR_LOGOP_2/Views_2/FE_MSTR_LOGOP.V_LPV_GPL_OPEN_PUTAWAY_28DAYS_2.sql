CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_GPL_OPEN_PUTAWAY_28DAYS_2(
   CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code'
 , WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)'
 , STOCK_ID COMMENT 'Surrogate key Original name: Bestandid'
 , SRC_PALLET_NR COMMENT 'Number of the pallet on which the stock is located. FK: References LPV.LHM.LHMNR and LPV.BEDSTAND.LHMNR. Original name - lhmnr'
 , ARTICLE_NR COMMENT 'Foreign Key. References LPV.AST.ANR.'
 , GR_DATE COMMENT 'Good Receiving Date'
 , P3_GR_PRIORITY COMMENT 'Priority'
 , DWH_UPDATED COMMENT 'Indication when the data is loaded'
 , TARGET_AREA_NR COMMENT 'Target Area of Open Putaways'
 , FIXBIN_ID COMMENT 'Location_2 that is set as the picking location. Foreign Key. References LPV.WHX.ORT'
 , GANG_NR COMMENT 'Calculated from FIXBIN_ID - the first 2 digits of location_2 ID'
) AS
SELECT
	be.client_id
   ,be.wh_id
   ,be.stock_id
   ,be.src_pallet_nr
   ,be.article_nr
   ,be.gr_date
   ,be.p3_gr_priority 
   ,be.dwh_updated
   ,IFF(astb.fixbin_id IS NOT NULL,area.reserve_area_nr
   ,IFF(ast.v2_item_group IN (10,11,12,13,14,30,31,32,33,35,36,40,42),701
   ,IFF(ast.v2_item_group IN (20,74),702
   ,IFF(ast.v2_item_group IN (41,43,44,45,46,47,48,49,50,51,52,54,60,61,62,63,70,71,72,73,77,80,81,82,83,84,85,86),700
   ,IFF(ast.v2_item_group IN (90,91,92),0
   ,IFF(ast.v2_item_group >100,706,0)))))) AS target_area_nr
   ,astb.fixbin_id
   ,CONCAT('Aisle',' ',SUBSTRING(astb.fixbin_id,1,2)) AS gang_nr
FROM "DATA".T_LPV_BESTAND_2 be
LEFT JOIN "DATA".T_LPV_ASTBER_2 astb
ON be.client_id = astb.client_id 
AND be.wh_id = astb.wh_id 
AND be.article_nr = astb.article_nr
AND CURRENT_DATE BETWEEN astb.dwh_valid_from AND astb.dwh_valid_to
AND astb.deleted_fg = FALSE
LEFT JOIN "DATA".T_LPV_WHX_2 w
ON astb.client_id = w.client_id 
AND astb.wh_id = w.wh_id 
AND astb.fixbin_id = w.location_id 
AND CURRENT_DATE BETWEEN w.dwh_valid_from AND w.dwh_valid_to
AND w.deleted_fg = FALSE
LEFT JOIN "DATA".T_LPV_AREA_2 area
ON w.client_id = area.client_id 
AND w.wh_id = area.wh_id 
AND w.area_nr = area.area_nr 
AND CURRENT_DATE BETWEEN area.dwh_valid_from AND area.dwh_valid_to
AND area.deleted_fg = FALSE
LEFT JOIN "DATA".T_LPV_AREA_2 res
ON area.client_id = res.client_id 
AND area.wh_id = res.wh_id 
AND area.reserve_area_nr = res.area_nr 
AND res.area_nr BETWEEN 700 AND 899
AND CURRENT_DATE BETWEEN res.dwh_valid_from AND res.dwh_valid_to
AND res.deleted_fg = FALSE
LEFT JOIN "DATA".t_lpv_ast_2 ast
ON be.client_id = ast.client_id
AND be.wh_id = ast.wh_id
AND be.article_nr = ast.article_nr
AND CURRENT_DATE BETWEEN ast.dwh_valid_from AND ast.dwh_valid_to
AND ast.deleted_fg = FALSE 
WHERE be.src_area_nr = 1000
AND CURRENT_DATE BETWEEN be.dwh_valid_from AND be.dwh_valid_to
AND be.deleted_fg = FALSE
AND be.gr_date BETWEEN CURRENT_DATE-28 AND CURRENT_DATE;