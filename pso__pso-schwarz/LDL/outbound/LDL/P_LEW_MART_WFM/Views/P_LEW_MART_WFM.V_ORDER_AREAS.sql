-- item location relation to recognize every possible combination for item to warehouse

/* find order areas based on warehouses */ /* find order areas based on stores */
-- item location relation to recognize every possible combination for item to warehouse

CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_order_areas (country_lidl_cd, wh_id, order_area_cd, order_area_descr) AS
SELECT CLNT.src_country_lidl_cd AS country_lidl_cd,
 LOC.src_orig_wh_nr AS wh_id,
 OA.order_area_nr AS order_area_cd,
 COALESCE(OAH.wh_order_area_name, OA.order_area_name) AS order_area_descr
FROM ldl_p_lew_core_ac.v_item_info_per_location_hist AS ITM_LOC_HIST
 INNER JOIN ldl_p_lew_core_ac.v_client AS CLNT ON ITM_LOC_HIST.client_id = CLNT.client_id
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON CLNT.client_id = LOC.client_id AND ITM_LOC_HIST.loc_sid = LOC.loc_sid
      AND LOC.wh_store_mark = 'B' AND COALESCE(LOC.global_loc_ctry_cd, '0') <> 'ZV' -- filter out Vorlagen

 INNER JOIN ldl_p_lew_core_ac.v_order_area AS OA ON ITM_LOC_HIST.client_id = OA.client_id AND ITM_LOC_HIST.order_area_sid
    = OA.order_area_sid
 LEFT JOIN ldl_p_lew_core_ac.v_warehouse_order_area_hist AS OAH ON ITM_LOC_HIST.client_id = OAH.client_id AND
     ITM_LOC_HIST.order_area_sid = OAH.order_area_sid AND ITM_LOC_HIST.loc_sid = OAH.loc_sid_wh AND CURRENT_DATE BETWEEN
   OAH.dwh_valid_from AND OAH.dwh_valid_to
WHERE CURRENT_DATE BETWEEN ITM_LOC_HIST.dwh_valid_from AND ITM_LOC_HIST.dwh_valid_to
  -- filter for technical valid entries only

 AND ITM_LOC_HIST.deleted_fg = 0
 AND TRIM(OA.order_area_nr) <> '-1' -- filter out dummy order areas

GROUP BY country_lidl_cd,
 wh_id,
 order_area_cd,
 order_area_descr
UNION DISTINCT
SELECT CLNT.src_country_lidl_cd AS country_lidl_cd,
 ST2WH.orig_wh_nr AS wh_id,
 OA.order_area_nr AS order_area_cd,
 COALESCE(OAH.wh_order_area_name, OA.order_area_name) AS order_area_descr
FROM ldl_p_lew_core_ac.v_item_info_per_location_hist AS ITM_LOC_HIST
 INNER JOIN ldl_p_lew_core_ac.v_client AS CLNT ON ITM_LOC_HIST.client_id = CLNT.client_id
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse AS ST2WH ON ITM_LOC_HIST.client_id = ST2WH.client_id AND ITM_LOC_HIST
    .loc_sid = ST2WH.loc_sid_store AND CURRENT_DATE BETWEEN ST2WH.dwh_valid_from AND ST2WH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_location_hist AS LOC ON ST2WH.client_id = LOC.client_id AND ST2WH.loc_sid_store = LOC.loc_sid
      AND (LOC.test_store_fg IS NULL OR LOC.test_store_fg = 0) AND CURRENT_DATE BETWEEN LOC.dwh_valid_from AND LOC.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_order_area AS OA ON ITM_LOC_HIST.client_id = OA.client_id AND ITM_LOC_HIST.order_area_sid
    = OA.order_area_sid
 LEFT JOIN ldl_p_lew_core_ac.v_warehouse_order_area_hist AS OAH ON ITM_LOC_HIST.client_id = OAH.client_id AND
     ITM_LOC_HIST.order_area_sid = OAH.order_area_sid AND ITM_LOC_HIST.loc_sid = OAH.loc_sid_wh AND CURRENT_DATE BETWEEN
   OAH.dwh_valid_from AND OAH.dwh_valid_to
WHERE CURRENT_DATE BETWEEN ITM_LOC_HIST.dwh_valid_from AND ITM_LOC_HIST.dwh_valid_to
  -- filter for technical valid entries only

 AND ITM_LOC_HIST.deleted_fg = 0
 AND TRIM(OA.order_area_nr) <> '-1'
GROUP BY country_lidl_cd,
 wh_id,
 order_area_cd,
 order_area_descr;