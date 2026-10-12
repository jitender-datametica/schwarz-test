
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_str_day_sig_return_asis
AS
SELECT AGG.client_id,
 AGG.loc_sid_store AS store_id,
 AGG.orig_wh_nr AS wh_id,
 AGG.src_subitemgrp_cd AS subitemgroup_id,
 AGG.dwh_cal_dt AS dat_formdate,
 2 AS return_receipttype_id,
 COALESCE(CAST(ROUND(CAST(AGG.return_reason_mark AS BIGNUMERIC), 0) AS BIGNUMERIC), - 1) AS return_reason_cd_ejr_sfo,
 SUM(AGG.ship_qty * - 1) AS qty_return_ejr_sfo,
  SUM(AGG.ship_val * - 1) / MAX(CURR.exchange_rate) AS val_return_ejr_sfo,
  SUM(AGG.ship_net_val * - 1) / MAX(CURR.exchange_rate) AS val_return_net_ejr_sfo,
 CURR.curr_cd_from AS currency_iso_cd,
 2 AS sysind
FROM ldl_p_lew_bil_ac.v_agg_store_day_return AS AGG
 INNER JOIN ldl_p_lew_mart_msi.v_report_fixed_exchange_rate AS CURR ON AGG.client_id = CURR.client_id AND CURRENT_DATE
   BETWEEN CURR.active_from_dt AND CURR.active_to_dt
GROUP BY AGG.client_id,
 store_id,
 wh_id,
 subitemgroup_id,
 dat_formdate,
 AGG.return_reason_mark,
 currency_iso_cd
UNION ALL
SELECT AGG.client_id,
 AGG.st_loc_sid AS store_id,
 WH.src_wh_id AS wh_id,
 AGG.subitemgroup_id,
 AGG.dat_formdate,
 AGG.return_receipttype_id,
 AGG.return_reason_cd_ejr_sfo,
 AGG.qty_return_ejr_sfo,
  AGG.val_return_ejr_sfo / CURR.exchange_rate AS val_return_ejr_sfo,
  AGG.val_return_net_ejr_sfo / CURR.exchange_rate AS val_return_net_ejr_sfo,
 CURR.curr_cd_from AS currency_iso_cd,
 1 AS sysind
FROM ldl_p_lew_core_ac.v_wawi_agg_str_day_sig_return_asis AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS WH ON AGG.client_id = WH.client_id AND AGG.st_loc_sid =
   WH.loc_sid_store
 INNER JOIN ldl_p_lew_mart_msi.v_report_fixed_exchange_rate AS CURR ON AGG.client_id = CURR.client_id AND CURRENT_DATE
   BETWEEN CURR.active_from_dt AND CURR.active_to_dt;

