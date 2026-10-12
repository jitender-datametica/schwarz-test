CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_agg_inv_item_wh_day_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT COALESCE(INV.client_id, ITM.client_id) AS client_id,
 COALESCE(INV.loc_sid, ITM.loc_sid) AS loc_sid,
 COALESCE(INV.wh_id, ITM.wh_id) AS wh_id,
 COALESCE(INV.item_id, ITM.item_id) AS item_id,
 COALESCE(INV.dat_formdate, ITM.booking_dat) AS dat_formdate,
 SUM(COALESCE(INV.inv_diff_total_piece, 0) + COALESCE(ITM.ship_qty, 0)) AS diff_inv_stc_calc_cnt,
 SUM(COALESCE(INV.inv_diff_total_val, 0) + COALESCE(ITM.gross_val, 0)) AS diff_inv_stc_calc_val,
 SUM(COALESCE(INV.inv_diff_total_net_val, 0) + COALESCE(ITM.sales_net_val, 0)) AS diff_inv_stc_calc_net_val,
 INV.inv_diff_total_piece AS diff_inv_qty,
 INV.inv_diff_total_val AS diff_inv_val,
 INV.inv_diff_total_net_val AS diff_inv_net_val,
 ITM.ship_qty AS diff_inv_return_qty,
 ITM.gross_val AS diff_inv_return_val,
 ITM.sales_net_val AS diff_inv_return_net_val,
  SUM(COALESCE(INV.inv_diff_total_val, 0) + COALESCE(ITM.gross_val, 0)) / CASE
   WHEN SUM(COALESCE(INV.inv_diff_total_piece, 0) + COALESCE(ITM.ship_qty, 0)) = 0
   THEN NULL
   ELSE SUM(COALESCE(INV.inv_diff_total_piece, 0) + COALESCE(ITM.ship_qty, 0))
   END AS gross_prcs_calc,
  SUM(COALESCE(INV.inv_diff_total_net_val, 0) + COALESCE(ITM.sales_net_val, 0)) / CASE
   WHEN SUM(COALESCE(INV.inv_diff_total_piece, 0) + COALESCE(ITM.ship_qty, 0)) = 0
   THEN NULL
   ELSE SUM(COALESCE(INV.inv_diff_total_piece, 0) + COALESCE(ITM.ship_qty, 0))
   END AS net_prcs_calc
FROM ldl_p_lew_mart_msi.v_agg_inv_diff_item_wh_day_2 AS INV
 FULL JOIN ldl_p_lew_mart_msi.v_agg_inv_return_item_wh_day_2 AS ITM ON INV.client_id = ITM.client_id AND INV.item_id = ITM
     .item_id AND INV.loc_sid = ITM.loc_sid AND INV.dat_formdate = ITM.booking_dat
GROUP BY client_id,
 loc_sid,
 wh_id,
 item_id,
 dat_formdate,
 diff_inv_qty,
 diff_inv_val,
 diff_inv_net_val,
 diff_inv_return_qty,
 diff_inv_return_val,
 diff_inv_return_net_val;