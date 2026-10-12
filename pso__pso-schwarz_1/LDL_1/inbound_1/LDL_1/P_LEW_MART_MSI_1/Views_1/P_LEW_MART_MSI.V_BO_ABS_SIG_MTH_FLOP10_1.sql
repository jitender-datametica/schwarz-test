CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_ABS_SIG_MTH_FLOP10_1
(
    client_id
    , store_id
    , wh_id
    , orig_item_nr
    , dat_valid_from
    , item_desc
    , subitemgroup_id
    , cy_month
    , currency_iso_cd
    , val_rtl_rl_sfo_store
    , val_rtl_rl_net_sfo_store
    , val_wrtoff_zero_store
    , val_wrtoff_zero_store_net
    , qty_total_sfo_store
    , qty_disc_piece_weigth_ejr_asis
    , val_discount_sfo
    , val_discount_net_sfo
    , val_rtl_ejr_adj
    , val_rtl_net_ejr_adj
    , sfo_to_val_retail_pct
    , sfo_to_val_retail_net_pct
    , rank_abs
    , rank_rel
)
AS
   SELECT
       client_id,
   store_id,
   wh_id,
   orig_item_nr,
   dat_valid_from,
   item_desc,
   subitemgroup_id,
   cy_month,
   currency_iso_cd,
   val_rtl_rl_sfo_store,
   val_rtl_rl_net_sfo_store,
   val_wrtoff_zero_store,
   val_wrtoff_zero_store_net,
   qty_total_sfo_store,
   qty_disc_piece_weigth_ejr_asis,
   val_discount_sfo,
   val_discount_net_sfo,
   val_rtl_ejr_adj,
   val_rtl_net_ejr_adj,
   sfo_to_val_retail_pct,
   sfo_to_val_retail_net_pct,
   rank_abs,
   rank_rel
   FROM p_lew_mart_msi.t_bo_base_flop10_1 AS v
   where target_type_id=3
;