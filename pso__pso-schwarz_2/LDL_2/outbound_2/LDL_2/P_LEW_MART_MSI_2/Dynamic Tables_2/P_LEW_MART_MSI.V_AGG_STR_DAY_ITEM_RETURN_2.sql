
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_str_day_item_return_2
AS
SELECT ELW_AGG.client_id,
 ELW_AGG.loc_sid_store AS store_id,
 ELW_AGG.orig_wh_nr AS wh_id,
 ITMP.item_sid_map AS item_id,
 ELW_AGG.dwh_cal_dt AS dat_formdate,
 2 AS return_receipttype_id,
 COALESCE(CAST(ROUND(CAST(ELW_AGG.return_reason_mark AS BIGNUMERIC), 0) AS BIGNUMERIC), - 1) AS return_reason_cd_ejr_sfo
 ,
  ELW_AGG.ship_qty * - 1 AS qty_return_ejr_sfo,
   ELW_AGG.ship_val * - 1 / CURR.exchange_rate AS val_return_ejr_sfo,
   ELW_AGG.ship_net_val * - 1 / CURR.exchange_rate AS val_return_net_ejr_sfo,
 CURR.curr_cd_from AS currency_iso_cd,
 2 AS sysind
FROM ldl_p_lew_bil_ac.v_agg_store_day_return_2 AS ELW_AGG
 INNER JOIN ldl_p_lew_mart_msi.v_report_fixed_exchange_rate_2 AS CURR ON ELW_AGG.client_id = CURR.client_id AND
   CURRENT_DATE BETWEEN CURR.active_from_dt AND CURR.active_to_dt
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON ELW_AGG.client_id = ITMP.client_id AND ELW_AGG.item_sid = ITMP.item_sid
   
UNION ALL
SELECT AGG.client_id,
 AGG.st_loc_sid AS store_id,
 S2W.src_wh_id AS wh_id,
 ITMP.item_sid_map AS item_id,
 AGG.dat_formdate,
 AGG.return_receipttype_id,
 AGG.return_reason_cd_ejr_sfo,
 AGG.qty_return_ejr_sfo,
  AGG.val_return_ejr_sfo / CURR.exchange_rate AS val_return_ejr_sfo,
  AGG.val_return_net_ejr_sfo / CURR.exchange_rate AS val_return_net_ejr_sfo,
 CURR.curr_cd_from AS currency_iso_code,
 1 AS sysind
FROM ldl_p_lew_core_ac.v_wawi_agg_str_day_item_return_2 AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS S2W ON AGG.client_id = S2W.client_id AND AGG.st_loc_sid =
   S2W.loc_sid_store
 INNER JOIN ldl_p_lew_mart_msi.v_report_fixed_exchange_rate_2 AS CURR ON AGG.client_id = CURR.client_id AND CURRENT_DATE
   BETWEEN CURR.active_from_dt AND CURR.active_to_dt
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON AGG.client_id = ITMP.client_id AND AGG.item_sid = ITMP.item_sid;
