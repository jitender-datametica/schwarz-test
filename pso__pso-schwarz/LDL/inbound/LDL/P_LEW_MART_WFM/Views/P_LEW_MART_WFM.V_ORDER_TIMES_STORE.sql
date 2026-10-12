CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ORDER_TIMES_STORE
(
    country_lidl_cd
   ,range_zone_id
   ,store
   ,order_area_cd
)
AS
   SELECT
   country_lidl_cd,
   range_zone_id,
   store,
   order_area_cd
   FROM
   (SELECT
   clnt.src_country_lidl_cd    AS country_lidl_cd,
   otr.src_range_zone_id       AS range_zone_id,
   s2w.orig_store_nr           AS store,
   oa.order_area_nr            AS order_area_cd,
   Row_Number() Over (PARTITION BY clnt.src_country_lidl_cd,sotr.wh_order_time_range_sid,s2w.orig_store_nr,sotr.order_area_sid ORDER BY s2w.dwh_valid_to DESC NULLS LAST) AS rownum_dat_rec_end
   FROM p_lew_core_ac.v_store_order_area_time_range_hist AS sotr

   INNER JOIN p_lew_core_ac.v_warehouse_order_time_range AS otr
   ON otr.client_id = sotr.client_id
   AND otr.wh_order_time_range_sid = sotr.wh_order_time_range_sid
   AND otr.loc_sid_wh = sotr.loc_sid_wh
   AND Current_Date BETWEEN sotr.dwh_valid_from AND sotr.dwh_valid_to
   AND sotr.deleted_fg = 0

   INNER JOIN p_lew_core_ac.v_order_area AS oa
   ON oa.client_id = sotr.client_id
   AND oa.order_area_sid = sotr.order_area_sid

   INNER JOIN p_lew_bil_ac.v_store_to_warehouse AS s2w
   ON sotr.client_id = s2w.client_id
   AND sotr.loc_sid_store = s2w.loc_sid_store
   AND sotr.loc_sid_wh = s2w.loc_sid_wh
   AND Current_Date BETWEEN s2w.dwh_valid_from AND s2w.dwh_valid_to    -- this check was missing in old version !

   INNER JOIN p_lew_core_ac.v_location AS loc2
   ON loc2.client_id = s2w.client_id
   AND loc2.loc_sid = s2w.loc_sid_store
   AND loc2.wh_store_mark = 'A'             -- filter for only stores

   INNER JOIN p_lew_core_ac.v_client AS clnt
   ON sotr.client_id = clnt.client_id
   
   INNER JOIN p_lew_core_ac.v_location_hist AS loc
   ON loc.client_id = s2w.client_id
   AND loc.loc_sid = s2w.loc_sid_store
   AND loc.test_store_fg = 0
   AND Current_Date BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to

   /* only valid store_order_area_time_range records */
   WHERE Current_Date BETWEEN sotr.dwh_valid_from AND sotr.dwh_valid_to
) AS ges
WHERE rownum_dat_rec_end = 1
;