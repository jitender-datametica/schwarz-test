CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_abs_sig_week_flop10_ges (account_manager_id, account_manager_name,
sales_manager_id, sales_manager_name, city, country_id, country_desc, country_iso_cd, orig_store_nr, store_desc, wh_desc
, client_id, store_id, wh_id, subitemgroup_id, cy_week, currency_iso_cd, val_rtl_rl_sfo_store, val_rtl_rl_net_sfo_store
, val_rtl_net_sfo_mhd_break, val_rtl_net_sfo_other_stc_loss, val_rtl_net_sfo_str_deliv_qlty, val_wrtoff_zero_store,
val_wrtoff_zero_store_net, val_wofz_st_net_mhd_break, val_wofz_st_net_other_stc_loss, val_wofz_st_net_deliv_qlty,
qty_total_sfo_store, qty_sfo_store_mhd_break, qty_sfo_store_other_stc_loss, qty_sfo_store_str_deliv_qlty,
qty_disc_piece_weigth_ejr_asis, val_discount_sfo, val_discount_net_sfo, val_rtl_ejr_adj, val_rtl_net_ejr_adj,
sfo_to_val_retail_pct, sfo_to_val_retail_net_pct) AS SELECT account_manager_id,
 account_manager_name,
 sales_manager_id,
 sales_manager_name,
 city,
 country_id,
 country_desc,
 country_iso_cd,
 orig_store_nr,
 store_desc,
 wh_desc,
 client_id,
 store_id,
 wh_id,
 subitemgroup_id,
 cy_week,
 currency_iso_cd,
 SUM(val_rtl_rl_sfo_store) AS val_rtl_rl_sfo_store,
 SUM(val_rtl_rl_net_sfo_store) AS val_rtl_rl_net_sfo_store,
 SUM(val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
 SUM(val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
 SUM(val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
 SUM(val_wrtoff_zero_store) AS val_wrtoff_zero_store,
 SUM(val_wrtoff_zero_store_net) AS val_wrtoff_zero_store_net,
 SUM(val_wrtoff_zero_store_net_mhd_break) AS val_wofz_st_net_mhd_break,
 SUM(val_wrtoff_zero_store_net_other_stc_loss) AS val_wofz_st_net_other_stc_loss,
 SUM(val_wrtoff_zero_store_net_str_deliv_qlty) AS val_wofz_st_net_deliv_qlty,
 SUM(qty_total_sfo_store) AS qty_total_sfo_store,
 SUM(qty_total_sfo_store_mhd_break) AS qty_sfo_store_mhd_break,
 SUM(qty_total_sfo_store_other_stc_loss) AS qty_sfo_store_other_stc_loss,
 SUM(qty_total_sfo_store_str_deliv_qlty) AS qty_sfo_store_str_deliv_qlty,
 SUM(qty_disc_piece_weigth_ejr_asis) AS qty_disc_piece_weigth_ejr_asis,
 SUM(val_discount_sfo) AS val_discount_sfo,
 SUM(val_discount_net_sfo) AS val_discount_net_sfo,
 SUM(val_rtl_ejr_adj) AS val_rtl_ejr_adj,
 SUM(val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj,
 CAST(COALESCE(COALESCE(SUM(val_wrtoff_zero_store), 0) / CASE
      WHEN SUM(val_rtl_ejr_adj) = 0
      THEN NULL
      ELSE SUM(val_rtl_ejr_adj)
      END, 0) * 100 AS BIGNUMERIC) AS sfo_to_val_retail_pct,
 CAST(COALESCE(COALESCE(SUM(val_wrtoff_zero_store_net), 0) / CASE
      WHEN SUM(val_rtl_net_ejr_adj) = 0
      THEN NULL
      ELSE SUM(val_rtl_net_ejr_adj)
      END, 0) * 100 AS BIGNUMERIC) AS sfo_to_val_retail_net_pct
FROM ldl_p_lew_mart_msi.t_bo_base_flop10 AS V
WHERE target_type_id = 2
GROUP BY account_manager_id,
 account_manager_name,
 sales_manager_id,
 sales_manager_name,
 city,
 country_id,
 country_desc,
 country_iso_cd,
 orig_store_nr,
 store_desc,
 wh_desc,
 client_id,
 store_id,
 wh_id,
 subitemgroup_id,
 cy_week,
 currency_iso_cd;