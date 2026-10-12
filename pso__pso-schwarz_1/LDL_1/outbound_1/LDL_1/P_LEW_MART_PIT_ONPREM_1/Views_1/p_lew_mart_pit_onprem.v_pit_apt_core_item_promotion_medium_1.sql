
CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_medium_1 (client_id, item_sid, promotion_dt
, advertising_medium_cd, advertising_medium_pos, deleted_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT DISTINCT
 APT.client_id,
 ItmMap.rltd_item_sid AS item_sid,
 APT.promotion_dt,
 CAST(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(COALESCE(APT.advertising_medium_cd, 'Sonstige'),'')) AS STRING) AS advertising_medium_cd,
 APT.advertising_medium_pos,
 APT.deleted_fg,
 APT.dwh_load_id,
 APT.dwh_created,
 APT.dwh_updated
FROM ldl_p_lew_core_ac.v_item_promotion_medium_adp_1 AS APT
 INNER JOIN (SELECT MAINITM.client_id,
   MAINITM.item_sid,
   ITM.item_sid AS rltd_item_sid
  FROM ldl_p_lew_core_ac.v_item_1 AS MAINITM
   INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON MAINITM.client_id = ITM.client_id AND ROUND(SAFE_CAST(COALESCE(MAINITM
         .src_orig_item_nr, TRIM(MAINITM.config_item_cd), MAINITM.src_matnr) AS BIGNUMERIC), 0) = ROUND(SAFE_CAST(COALESCE(ITM
         .src_orig_item_nr, TRIM(ITM.config_item_cd), ITM.src_matnr) AS BIGNUMERIC), 0) AND (MAINITM.src_dat_valid_from
       IS NULL OR ITM.src_dat_valid_from IS NULL OR MAINITM.src_dat_valid_from = ITM.src_dat_valid_from)
  GROUP BY MAINITM.client_id,
   MAINITM.item_sid,
   rltd_item_sid) AS ItmMap ON APT.client_id = ItmMap.client_id AND APT.item_sid = ItmMap.item_sid
WHERE APT.deleted_fg = 0;
