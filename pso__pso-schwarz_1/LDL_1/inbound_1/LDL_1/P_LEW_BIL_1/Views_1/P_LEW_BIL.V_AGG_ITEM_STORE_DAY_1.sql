CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_ITEM_STORE_DAY_1
(
client_id
, loc_sid_store
, src_orig_store_nr
, src_wh_id
, dwh_cal_dt
, cy_month
, item_sid
, retail_val
, retail_net_val
, qty_act
, diff_inv_stc_calc_cnt
, diff_inv_stc_calc_val
, diff_inv_stc_calc_net_val
, diff_inv_return_qty
, diff_inv_return_val
, diff_inv_return_net_val
, abs_val
, net_abs_val
, pr_diff_del_val
, pr_diff_net_del_val
, pr_diff_return_val
, pr_diff_net_return_val
, pv_val
, net_pv_val
, claim_val
, claim_net_val
, retail_fa_val
, retail_net_fa_val
, return_fa_val
, return_net_fa_val
, qty_piece_fa
, qty_return_fa
, diff_inv_stc_calc_cnt_fa
, diff_inv_stc_calc_val_fa
, diff_inv_stc_calc_net_val_fa
, diff_inv_return_fa_qty
, diff_inv_return_fa_val
, diff_inv_return_net_fa_val
, abs_fa_val
, net_abs_fa_val
, pr_diff_fa_del_val
, pr_diff_net_fa_del_val
, pr_diff_fa_return_val
, pr_diff_net_fa_return_val
, pv_fa_val
, net_pv_fa_val
, claim_fa_val
, claim_net_fa_val
)
AS
   SELECT
   client_id,
   loc_sid_store,
   src_orig_store_nr,
   src_wh_id,
   dwh_cal_dt,
   cy_month,
   item_sid,
   retail_val,
   retail_net_val,
   qty_act,
   diff_inv_stc_calc_cnt,
   diff_inv_stc_calc_val,
   diff_inv_stc_calc_net_val,
   diff_inv_return_qty,
   diff_inv_return_val,
   diff_inv_return_net_val,
   abs_val,
   net_abs_val,
   pr_diff_del_val,
   pr_diff_net_del_val,
   pr_diff_return_val,
   pr_diff_net_return_val,
   pv_val,
   net_pv_val,
   claim_val,
   claim_net_val,
   retail_fa_val,
   retail_net_fa_val,
   return_fa_val,
   return_net_fa_val,
   qty_piece_fa,
   qty_return_fa,
   diff_inv_stc_calc_cnt_fa,
   diff_inv_stc_calc_val_fa,
   diff_inv_stc_calc_net_val_fa,
   diff_inv_return_fa_qty,
   diff_inv_return_fa_val,
   diff_inv_return_net_fa_val,
   abs_fa_val,
   net_abs_fa_val,
   pr_diff_fa_del_val,
   pr_diff_net_fa_del_val,
   pr_diff_fa_return_val,
   pr_diff_net_fa_return_val,
   pv_fa_val,
   net_pv_fa_val,
   claim_fa_val,
   claim_net_fa_val
  FROM p_lew_bil.t_agg_item_store_day_1
;