/* DescStart
   $Revision: 8320 $, $LastChangedBy: mueding $
   SubjectAreas: Anliefermenge
   DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_store_mth_item_del_asis_2 AS SELECT AJI.client_id,
 AJI.loc_sid_store AS store_id,
 AJI.cy_month AS month_id,
 AJI.deliverytype_id,
 ITMP.item_sid_map AS item_id,
 AJI.orig_store_nr,
 AJI.qty_total_del AS qty_total_del_asis,
  AJI.val_rtl_rl_del / B.exchange_rate AS val_rtl_rl_del_asis,
  AJI.val_rtl_rl_net_del / B.exchange_rate AS val_rtl_rl_net_del_asis,
 AJI.qty_piece_del AS qty_piece_del_asis,
  AJI.val_piece_del / B.exchange_rate AS val_piece_del_asis,
  AJI.val_piece_net_del / B.exchange_rate AS val_piece_net_del_asis,
  AJI.val_pr_diff_del / B.exchange_rate AS val_pr_diff_del_asis,
  AJI.val_pr_diff_net_del / B.exchange_rate AS val_pr_diff_net_del_asis,
 AJI.qty_total_fa_del AS qty_total_fa_del_asis,
  AJI.val_rtl_rl_fa_del / B.exchange_rate AS val_rtl_rl_fa_del_asis,
  AJI.val_rtl_rl_net_fa_del / B.exchange_rate AS val_rtl_rl_net_fa_del_asis,
 AJI.qty_piece_fa_del AS qty_piece_fa_del_asis,
  AJI.val_piece_fa_del / B.exchange_rate AS val_piece_fa_del_asis,
  AJI.val_piece_net_fa_del / B.exchange_rate AS val_piece_net_fa_del_asis,
  AJI.val_pr_diff_fa_del / B.exchange_rate AS val_pr_diff_fa_del_asis,
  AJI.val_pr_diff_net_fa_del / B.exchange_rate AS val_pr_diff_net_fa_del_asis,
 B.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_aji_deliv_store_mth_item_2 AS AJI
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS B ON AJI.client_id = B.client_id AND CURRENT_DATE BETWEEN B
     .active_from_dt AND B.active_to_dt AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to AND B.deleted_fg =
   0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON AJI.client_id = ITMP.client_id AND AJI.item_sid = ITMP.item_sid;