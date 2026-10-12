/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for Std
#----------------------------------------------------------------------------
# History:
# 1.0 05.08.2021 Panaeru, Raman              Creation
#----------------------------------------------------------------------------
*/




CREATE OR REPLACE VIEW ldl_p_lew_load.v_location_item_price_1 AS SELECT y.client_id,
 y.loc_sid,
 y.item_sid,
 y.dwh_cal_dt,
 y.price_retail,
 y.price_level
FROM (SELECT client_id,
   st_loc_sid,
   wh_loc_sid,
   pricegroup_id,
   priority,
   dat_valid_from,
   dat_valid_until
  FROM ldl_p_lew_core_ac.v_wawi_itm_pricegroup_1 AS IPG
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_load.t_location_item_price_tmp_1)
   AND dat_valid_from <= (SELECT MAX(dwh_cal_dt)
     FROM ldl_p_lew_load.t_location_item_price_tmp_1)
   AND dat_valid_until >= (SELECT MIN(dwh_cal_dt)
     FROM ldl_p_lew_load.t_location_item_price_tmp_1)) AS drv1
 INNER JOIN (SELECT x.client_id,
   x.loc_sid_search,
   x.loc_sid,
   x.item_sid,
   x.dwh_cal_dt,
   x.price_level,
   x.wh_loc_sid,
   drv2.price_retail,
   drv2.pricegroup_id,
   drv2.dat_valid_from
  FROM (SELECT client_id,
     item_sid,
     pricegroup_id,
     price_retail,
     dat_valid_from,
     dat_valid_until
    FROM ldl_p_lew_core_ac.v_wawi_itm_price_1 AS IPR
    WHERE client_id IN (SELECT client_id
       FROM ldl_p_lew_load.t_location_item_price_tmp_1)
     AND dat_valid_from <= (SELECT MAX(dwh_cal_dt)
       FROM ldl_p_lew_load.t_location_item_price_tmp_1)
     AND dat_valid_until >= (SELECT MIN(dwh_cal_dt)
       FROM ldl_p_lew_load.t_location_item_price_tmp_1)) AS drv2
   INNER JOIN (SELECT T.client_id,
      T.loc_sid,
      T.item_sid,
      T.dwh_cal_dt,
      T.loc_sid AS loc_sid_search,
      1 AS price_level,
      CAST(NULL AS BIGNUMERIC) AS wh_loc_sid
     FROM ldl_p_lew_load.t_location_item_price_tmp_1 AS T
      INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_1 AS LMK ON T.client_id = LMK.client_id AND T.loc_sid = LMK.loc_sid AND
        LMK.loc_cd = 'A'
     UNION ALL
     SELECT T.client_id,
      T.loc_sid,
      T.item_sid,
      T.dwh_cal_dt,
      LMK2.loc_sid AS loc_sid_search,
      1 AS price_level,
      CAST(NULL AS BIGNUMERIC) AS wh_loc_sid
     FROM ldl_p_lew_load.t_location_item_price_tmp_1 AS T
      INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_1 AS LMK ON T.client_id = LMK.client_id AND T.loc_sid = LMK.loc_sid AND
        LMK.loc_cd = 'B'
      INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_1 AS LMK2 ON LMK.client_id = LMK2.client_id AND LMK.wawi_dwh_wh_id = LMK2
         .wawi_dwh_orig_store_nr AND LMK2.loc_cd = 'A'
     UNION ALL
     SELECT T.client_id,
      T.loc_sid,
      T.item_sid,
      T.dwh_cal_dt,
      MPS.loc_sid AS loc_sid_search,
      2 AS price_level,
      CAST(NULL AS BIGNUMERIC) AS wh_loc_sid
     FROM ldl_p_lew_load.t_location_item_price_tmp_1 AS T
      INNER JOIN ldl_p_lew_core_ac.v_store_to_wh_delivery_hist_1 AS STW ON T.client_id = STW.client_id AND T.loc_sid = STW
            .loc_sid_store AND T.dwh_cal_dt BETWEEN STW.active_from_dt AND STW.active_to_dt AND T.dwh_cal_dt BETWEEN STW
          .dwh_valid_from AND STW.dwh_valid_to AND STW.item_grp_sid = - 1 * STW.client_id AND STW.deleted_fg = 0
      INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_1 AS MPW ON STW.client_id = MPW.client_id AND STW.loc_sid_wh = MPW.loc_sid
          AND MPW.loc_cd = 'B'
      INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_1 AS MPS ON MPW.client_id = MPS.client_id AND MPW.wawi_dwh_wh_id = MPS.wawi_dwh_orig_store_nr
          AND MPS.loc_cd = 'A'
     UNION ALL
     SELECT T.client_id,
      T.loc_sid,
      T.item_sid,
      T.dwh_cal_dt,
      LMK.loc_sid AS loc_sid_search,
      3 AS price_level,
      COALESCE(STW.loc_sid_wh, T.loc_sid) AS wh_loc_sid
     FROM ldl_p_lew_load.t_location_item_price_tmp_1 AS T
      INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_1 AS LMK ON T.client_id = LMK.client_id AND LMK.wawi_dwh_store_id = 0
      LEFT JOIN ldl_p_lew_core_ac.v_store_to_wh_delivery_hist_1 AS STW ON T.client_id = STW.client_id AND T.loc_sid = STW
            .loc_sid_store AND T.dwh_cal_dt BETWEEN STW.active_from_dt AND STW.active_to_dt AND T.dwh_cal_dt BETWEEN STW
          .dwh_valid_from AND STW.dwh_valid_to AND STW.item_grp_sid = - 1 * STW.client_id AND STW.deleted_fg = 0) AS x
   ON drv2.client_id = x.client_id AND drv2.item_sid = x.item_sid AND x.dwh_cal_dt BETWEEN drv2.dat_valid_from AND drv2
     .dat_valid_until
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(x.client_id AS STRING), CAST(x.loc_sid AS STRING), CAST(x.loc_sid_search AS STRING)
        , CAST(x.item_sid AS STRING), x.dwh_cal_dt, drv2.pricegroup_id ORDER BY drv2.dat_valid_from IS NULL DESC, drv2.dat_valid_from
        DESC)) = 1) AS y ON drv1.client_id = y.client_id AND drv1.st_loc_sid = y.loc_sid_search AND drv1.pricegroup_id =
    y.pricegroup_id AND y.dwh_cal_dt BETWEEN drv1.dat_valid_from AND drv1.dat_valid_until
WHERE y.price_level <> 3
 OR drv1.wh_loc_sid = y.wh_loc_sid
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(y.client_id AS STRING), CAST(y.loc_sid AS STRING), CAST(y.item_sid AS STRING)
      , y.dwh_cal_dt ORDER BY drv1.priority IS NULL DESC, drv1.priority DESC, y.dat_valid_from IS NULL DESC, y.dat_valid_from
      DESC, drv1.pricegroup_id IS NULL, drv1.pricegroup_id)) = 1;
