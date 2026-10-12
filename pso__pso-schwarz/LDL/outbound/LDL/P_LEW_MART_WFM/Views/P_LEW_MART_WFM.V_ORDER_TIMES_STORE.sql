CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_order_times_store (country_lidl_cd, range_zone_id, store, order_area_cd) AS
SELECT CLNT.src_country_lidl_cd AS country_lidl_cd,
 OTR.src_range_zone_id AS range_zone_id,
 S2W.orig_store_nr AS store,
 OA.order_area_nr AS order_area_cd
FROM ldl_p_lew_core_ac.v_store_order_area_time_range_hist AS SOTR
 INNER JOIN ldl_p_lew_core_ac.v_warehouse_order_time_range AS OTR ON SOTR.client_id = OTR.client_id AND SOTR.wh_order_time_range_sid
       = OTR.wh_order_time_range_sid AND SOTR.loc_sid_wh = OTR.loc_sid_wh AND CURRENT_DATE BETWEEN SOTR.dwh_valid_from
    AND SOTR.dwh_valid_to AND SOTR.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_order_area AS OA ON SOTR.client_id = OA.client_id AND SOTR.order_area_sid = OA.order_area_sid
   
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse AS S2W ON SOTR.client_id = S2W.client_id AND SOTR.loc_sid_store = S2W
     .loc_sid_store AND SOTR.loc_sid_wh = S2W.loc_sid_wh AND CURRENT_DATE BETWEEN S2W.dwh_valid_from AND S2W.dwh_valid_to
   -- this check was missing in old version !

 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC2 ON S2W.client_id = LOC2.client_id AND S2W.loc_sid_store = LOC2.loc_sid
  AND LOC2.wh_store_mark = 'A' -- filter for only stores

 INNER JOIN ldl_p_lew_core_ac.v_client AS CLNT ON SOTR.client_id = CLNT.client_id
 INNER JOIN ldl_p_lew_core_ac.v_location_hist AS LOC ON S2W.client_id = LOC.client_id AND S2W.loc_sid_store = LOC.loc_sid
      AND LOC.test_store_fg = 0 AND CURRENT_DATE BETWEEN LOC.dwh_valid_from AND LOC.dwh_valid_to
   /* only valid store_order_area_time_range records */
WHERE CURRENT_DATE BETWEEN SOTR.dwh_valid_from AND SOTR.dwh_valid_to
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CLNT.src_country_lidl_cd, CAST(SOTR.wh_order_time_range_sid AS STRING), CAST(S2W.orig_store_nr AS STRING)
      , CAST(SOTR.order_area_sid AS STRING) ORDER BY S2W.dwh_valid_to IS NULL, S2W.dwh_valid_to)) = 1;