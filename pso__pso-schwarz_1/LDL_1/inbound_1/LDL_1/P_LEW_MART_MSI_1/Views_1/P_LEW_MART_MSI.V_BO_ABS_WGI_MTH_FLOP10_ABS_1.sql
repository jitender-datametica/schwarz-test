CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_ABS_WGI_MTH_FLOP10_ABS_1
(
 account_manager_id
, account_manager_name
, sales_manager_id
, sales_manager_name
, city
, country_id
, country_desc
, country_iso_cd
, orig_store_nr
, store_desc
, wh_desc
, client_id
, store_id
, wh_id
, orig_item_nr
, dat_valid_from
, item_desc
, item_wgi_id
, cy_month
, currency_iso_cd
, val_rtl_rl_sfo_store
, val_rtl_rl_net_sfo_store
, val_rtl_net_sfo_mhd_break
, val_rtl_net_sfo_other_stc_loss
, val_rtl_net_sfo_str_deliv_qlty
, val_wrtoff_zero_store
, val_wrtoff_zero_store_net
, val_wofz_st_net_mhd_break
, val_wofz_st_net_other_stc_loss
, val_wofz_st_net_deliv_qlty
, qty_total_sfo_store
, qty_sfo_store_mhd_break
, qty_sfo_store_other_stc_loss
, qty_sfo_store_str_deliv_qlty
, qty_disc_piece_weigth_ejr_asis
, val_discount_sfo
, val_discount_net_sfo
, val_rtl_ejr_adj
, val_rtl_net_ejr_adj
, sfo_to_val_retail_pct
, sfo_to_val_retail_net_pct
)
AS
   SELECT
        account_manager_id,
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
   orig_item_nr,
   dat_valid_from,
   item_desc,
   item_wgi_id,
   cy_month,
   currency_iso_cd,
   val_rtl_rl_sfo_store,
   val_rtl_rl_net_sfo_store,
   val_rtl_net_sfo_mhd_break,
   val_rtl_net_sfo_other_stc_loss,
   val_rtl_net_sfo_str_deliv_qlty,
   val_wrtoff_zero_store,
   val_wrtoff_zero_store_net,
   v.val_wrtoff_zero_store_net_mhd_break      AS val_wofz_st_net_mhd_break,
   v.val_wrtoff_zero_store_net_other_stc_loss AS val_wofz_st_net_other_stc_loss,
   v.val_wrtoff_zero_store_net_str_deliv_qlty AS val_wofz_st_net_deliv_qlty,
   qty_total_sfo_store,
   v.qty_total_sfo_store_mhd_break      AS qty_sfo_store_mhd_break,
   v.qty_total_sfo_store_other_stc_loss AS qty_sfo_store_other_stc_loss,
   v.qty_total_sfo_store_str_deliv_qlty AS qty_sfo_store_str_deliv_qlty,
   qty_disc_piece_weigth_ejr_asis,
   val_discount_sfo,
   val_discount_net_sfo,
   val_rtl_ejr_adj,
   val_rtl_net_ejr_adj,
   sfo_to_val_retail_pct,
   sfo_to_val_retail_net_pct
   FROM p_lew_mart_msi.t_bo_base_flop10_1 AS v
   where target_type_id=6
     and v.rank_abs  <= 10
;