CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_ABS_SIG_DAY_FLOP10_REL_2
/*
#DescStart#
#$Revision: 9232 $, $LastChangedBy: mstrauch $
#SubjectAreas#: Backoffice / Mobile
#DescEnd#
*/
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
, subitemgroup_id
, dat_formdate
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
     v.account_manager_id,
   v.account_manager_name,
   v.sales_manager_id,
   v.sales_manager_name,
   v.city,
   v.country_id,
   v.country_desc,
   v.country_iso_cd,
   v.orig_store_nr,
   v.store_desc,
   v.wh_desc,
   v.client_id,
   v.store_id,
   v.wh_id,
   v.orig_item_nr,
   v.dat_valid_from,
   v.item_desc,
   v.subitemgroup_id,
   v.dat_formdate,
   v.currency_iso_cd,
   v.val_rtl_rl_sfo_store,
   v.val_rtl_rl_net_sfo_store,
   v.val_rtl_net_sfo_mhd_break,
   v.val_rtl_net_sfo_other_stc_loss,
   v.val_rtl_net_sfo_str_deliv_qlty,
   v.val_wrtoff_zero_store,
   v.val_wrtoff_zero_store_net,
   v.val_wrtoff_zero_store_net_mhd_break      AS val_wofz_st_net_mhd_break,
   v.val_wrtoff_zero_store_net_other_stc_loss AS val_wofz_st_net_other_stc_loss,
   v.val_wrtoff_zero_store_net_str_deliv_qlty AS val_wofz_st_net_deliv_qlty,
   v.qty_total_sfo_store,
   v.qty_total_sfo_store_mhd_break      AS qty_sfo_store_mhd_break,
   v.qty_total_sfo_store_other_stc_loss AS qty_sfo_store_other_stc_loss,
   v.qty_total_sfo_store_str_deliv_qlty AS qty_sfo_store_str_deliv_qlty,
   v.qty_disc_piece_weigth_ejr_asis,
   v.val_discount_sfo,
   v.val_discount_net_sfo,
   v.val_rtl_ejr_adj,
   v.val_rtl_net_ejr_adj,
   v.sfo_to_val_retail_pct,
   v.sfo_to_val_retail_net_pct
  FROM p_lew_mart_msi.t_bo_base_flop10_2 AS v
   where v.target_type_id=1
     and v.rank_rel  <= 10
;