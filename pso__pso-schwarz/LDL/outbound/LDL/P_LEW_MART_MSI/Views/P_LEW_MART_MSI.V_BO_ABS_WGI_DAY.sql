CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_abs_wgi_day AS SELECT client_id,
 country_desc,
 country_id,
 country_iso_cd,
 store_id,
 orig_store_nr,
 store_desc,
 city,
 wh_id,
 wh_desc,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 itemgroup_int_id AS item_wgi_id,
 dat_formdate,
 cy_week AS week_page_by,
 currency_iso_cd,
 SUM(val_rtl_rl_sfo) AS val_rtl_rl_sfo_store_asis,
 SUM(val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo_store_asis,
 SUM(val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
 SUM(val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
 SUM(val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
 SUM(val_wrtoff_zero) AS val_wrtoff_zero_asis,
 SUM(val_wrtoff_zero_net) AS val_wrtoff_zero_net_asis,
 SUM(val_wrtoff_zero_net_mhd_break) AS val_wofz_st_net_mhd_break,
 SUM(val_wrtoff_zero_net_other_stc_loss) AS val_wofz_st_net_other_stc_loss,
 SUM(val_wrtoff_zero_net_str_deliv_qlty) AS val_wofz_st_net_deliv_qlty,
 SUM(val_discount_ejr) AS val_discount_sfo_asis,
 SUM(val_discount_net_ejr) AS val_discount_net_sfo_asis,
 SUM(val_rtl_ejr_adj) AS val_rtl_ejr_adj_asis,
 SUM(val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj_asis,
 CAST(IFNULL(SUM(val_rtl_rl_sfo) / CASE
     WHEN SUM(val_rtl_ejr_adj) = 0
     THEN NULL
     ELSE SUM(val_rtl_ejr_adj)
     END, 0) AS BIGNUMERIC) AS sfo_to_val_retail_pct,
 CAST(IFNULL(SUM(val_rtl_rl_net_sfo) / CASE
     WHEN SUM(val_rtl_net_ejr_adj) = 0
     THEN NULL
     ELSE SUM(val_rtl_net_ejr_adj)
     END, 0) AS BIGNUMERIC) AS sfo_to_val_retail_net_pct
FROM ldl_p_lew_mart_msi.t_bo_base_abs AS BASE
WHERE cy_week_seq BETWEEN - 4 AND 0
 AND itemgroup_int_id >= 0
 AND (val_rtl_rl_sfo IS NOT NULL OR val_rtl_rl_net_sfo IS NOT NULL OR val_wrtoff_zero IS NOT NULL OR val_wrtoff_zero_net
       IS NOT NULL OR val_discount_ejr IS NOT NULL OR val_discount_net_ejr IS NOT NULL OR val_rtl_ejr_adj IS NOT NULL OR
   val_rtl_net_ejr_adj IS NOT NULL)
GROUP BY client_id,
 country_desc,
 country_id,
 country_iso_cd,
 store_id,
 orig_store_nr,
 store_desc,
 city,
 wh_id,
 wh_desc,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 item_wgi_id,
 dat_formdate,
 week_page_by,
 currency_iso_cd;