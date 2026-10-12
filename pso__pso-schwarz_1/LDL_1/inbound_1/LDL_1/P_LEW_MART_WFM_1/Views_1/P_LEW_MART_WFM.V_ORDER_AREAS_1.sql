CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ORDER_AREAS_1
(
    country_lidl_cd
   ,wh_id
   ,order_area_cd
   ,order_area_descr
)
AS

   /* find order areas based on warehouses */
   SELECT
   clnt.src_country_lidl_cd                            AS country_lidl_cd,
   loc.src_orig_wh_nr                                  AS wh_id,
   oa.order_area_nr                                    AS order_area_cd,
   Coalesce(oah.wh_order_area_name,oa.order_area_name) AS order_area_descr

   --item_1 location_1 relation to recognize every possible combination for item_1 to warehouse
   FROM p_lew_core_ac.v_item_info_per_location_hist_1 AS itm_loc_hist
   INNER JOIN p_lew_core_ac.v_client_1 AS clnt
   ON itm_loc_hist.client_id = clnt.client_id
   INNER JOIN p_lew_core_ac.v_location_1 AS loc
   ON loc.client_id = clnt.client_id
   AND loc.loc_sid = itm_loc_hist.loc_sid
   AND loc.wh_store_mark = 'B'
   AND Coalesce(loc.global_loc_ctry_cd,'0') <> 'ZV'  -- filter out Vorlagen          

   INNER JOIN p_lew_core_ac.v_order_area_1 AS oa
   ON itm_loc_hist.client_id = oa.client_id
   AND itm_loc_hist.order_area_sid = oa.order_area_sid
   LEFT OUTER JOIN p_lew_core_ac.v_warehouse_order_area_hist_1 AS oah
   ON itm_loc_hist.client_id = oah.client_id
   AND itm_loc_hist.order_area_sid = oah.order_area_sid
   AND itm_loc_hist.loc_sid = oah.loc_sid_wh
   AND Current_Date BETWEEN oah.dwh_valid_from AND oah.dwh_valid_to

   WHERE Current_Date BETWEEN itm_loc_hist.dwh_valid_from AND itm_loc_hist.dwh_valid_to  --filter for technical valid entries only
     AND itm_loc_hist.deleted_fg = 0
     AND Trim(oa.order_area_nr) <> '-1'                                                  --filter out dummy_1 order areas

   GROUP BY 1,2,3,4

   UNION

   /* find order areas based on stores */
   SELECT
   clnt.src_country_lidl_cd                            AS country_lidl_cd,
   st2wh.orig_wh_nr                                    AS wh_id,
   oa.order_area_nr                                    AS order_area_cd,
   Coalesce(oah.wh_order_area_name,oa.order_area_name) AS order_area_descr

   --item_1 location_1 relation to recognize every possible combination for item_1 to warehouse
   FROM p_lew_core_ac.v_item_info_per_location_hist_1 AS itm_loc_hist
   INNER JOIN p_lew_core_ac.v_client_1 AS clnt
   ON itm_loc_hist.client_id = clnt.client_id
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_1 AS st2wh
   ON itm_loc_hist.client_id = st2wh.client_id
   AND itm_loc_hist.loc_sid = st2wh.loc_sid_store
   AND Current_Date BETWEEN st2wh.dwh_valid_from AND st2wh.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_location_hist_1 AS loc
   ON loc.client_id = st2wh.client_id
   AND loc.loc_sid = st2wh.loc_sid_store
   AND (loc.test_store_fg IS NULL OR loc.test_store_fg = 0)
   AND Current_Date BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_order_area_1 AS oa
   ON itm_loc_hist.client_id = oa.client_id
   AND itm_loc_hist.order_area_sid = oa.order_area_sid
   LEFT OUTER JOIN p_lew_core_ac.v_warehouse_order_area_hist_1 AS oah
   ON itm_loc_hist.client_id = oah.client_id
   AND itm_loc_hist.order_area_sid = oah.order_area_sid
   AND itm_loc_hist.loc_sid = oah.loc_sid_wh
   AND Current_Date BETWEEN oah.dwh_valid_from AND oah.dwh_valid_to

   WHERE Current_Date BETWEEN itm_loc_hist.dwh_valid_from AND itm_loc_hist.dwh_valid_to  --filter for technical valid entries only
     AND itm_loc_hist.deleted_fg = 0
     AND Trim(oa.order_area_nr) <> '-1'

   GROUP BY 1,2,3,4
;