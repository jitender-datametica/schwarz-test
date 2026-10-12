CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_ITEM_STORE_DAY_1
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
, dwh_updated
)
AS
SELECT
agg.client_id,
agg.loc_sid_store,
agg.src_orig_store_nr,
agg.src_wh_id,
agg.dwh_cal_dt,
agg.cy_month,
agg.item_sid,
agg.retail_val,
agg.retail_net_val,
agg.qty_act,
agg.diff_inv_stc_calc_cnt,
agg.diff_inv_stc_calc_val,
agg.diff_inv_stc_calc_net_val,
agg.diff_inv_return_qty,
agg.diff_inv_return_val,
agg.diff_inv_return_net_val,
agg.abs_val,
agg.net_abs_val,
agg.pr_diff_del_val,
agg.pr_diff_net_del_val,
agg.pr_diff_return_val,
agg.pr_diff_net_return_val,
agg.pv_val,
agg.net_pv_val,
agg.claim_val,
agg.claim_net_val,
agg.retail_fa_val,
agg.retail_net_fa_val,
agg.return_fa_val,
agg.return_net_fa_val,
agg.qty_piece_fa,
agg.qty_return_fa,
agg.diff_inv_stc_calc_cnt_fa,
agg.diff_inv_stc_calc_val_fa,
agg.diff_inv_stc_calc_net_val_fa,
agg.diff_inv_return_fa_qty,
agg.diff_inv_return_fa_val,
agg.diff_inv_return_net_fa_val,
agg.abs_fa_val,
agg.net_abs_fa_val,
agg.pr_diff_fa_del_val,
agg.pr_diff_net_fa_del_val,
agg.pr_diff_fa_return_val,
agg.pr_diff_net_fa_return_val,
agg.pv_fa_val,
agg.net_pv_fa_val,
agg.claim_fa_val,
agg.claim_net_fa_val,
CURRENT_TIMESTAMP(6) AS dwh_updated
FROM
(SELECT
coalesce(rtl_inv.client_id, rtrn.client_id)                                 AS client_id,
coalesce(rtl_inv.loc_sid_store, rtrn.loc_sid_store)                 AS loc_sid_store,
coalesce(rtl_inv.src_orig_store_nr, rtrn.src_orig_store_nr)    AS src_orig_store_nr,
coalesce(rtl_inv.src_wh_id, rtrn.src_wh_id)                          AS src_wh_id,
coalesce(rtl_inv.dwh_cal_dt, rtrn.dwh_cal_dt)                       AS dwh_cal_dt,
coalesce(rtl_inv.cy_month, rtrn.cy_month)                           AS cy_month,
coalesce(rtl_inv.item_sid, rtrn.item_sid)                               AS item_sid,
coalesce(rtl_inv.retail_val, 0)                                               AS retail_val,
coalesce(rtl_inv.retail_net_val, 0)                                         AS retail_net_val,
coalesce(rtl_inv.qty_act, 0)                                                  AS qty_act,
coalesce(rtl_inv.diff_inv_stc_calc_cnt, 0)                             AS diff_inv_stc_calc_cnt,
coalesce(rtl_inv.diff_inv_stc_calc_val, 0)                             AS diff_inv_stc_calc_val,
coalesce(rtl_inv.diff_inv_stc_calc_net_val, 0)                       AS diff_inv_stc_calc_net_val,
coalesce(rtrn.ship_qty, 0)                                                   AS diff_inv_return_qty,
coalesce(rtrn.gross_val, 0)                                                 AS diff_inv_return_val,
coalesce(rtrn.sales_net_val, 0)                                           AS diff_inv_return_net_val,
CAST(0 AS DECIMAL(18,5))                                                 AS abs_val,
CAST(0 AS DECIMAL(18,5))                                                 AS net_abs_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pr_diff_del_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pr_diff_net_del_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pr_diff_return_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pr_diff_net_return_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pv_val,
CAST(0 AS DECIMAL(18,5))                                                 AS net_pv_val,
CAST(0 AS DECIMAL(18,5))                                                 AS claim_val,
CAST(0 AS DECIMAL(18,5))                                                 AS claim_net_val,
CAST(0 AS DECIMAL(18,5))                                                 AS retail_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS retail_net_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS return_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS return_net_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS qty_piece_fa,
CAST(0 AS DECIMAL(18,5))                                                 AS qty_return_fa,
CAST(0 AS DECIMAL(18,5))                                                 AS diff_inv_stc_calc_cnt_fa,
CAST(0 AS DECIMAL(18,5))                                                 AS diff_inv_stc_calc_val_fa,
CAST(0 AS DECIMAL(18,5))                                                 AS diff_inv_stc_calc_net_val_fa,
CAST(0 AS DECIMAL(18,5))                                                 AS diff_inv_return_fa_qty,
CAST(0 AS DECIMAL(18,5))                                                 AS diff_inv_return_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS diff_inv_return_net_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS abs_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS net_abs_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pr_diff_fa_del_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pr_diff_net_fa_del_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pr_diff_fa_return_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pr_diff_net_fa_return_val,
CAST(0 AS DECIMAL(18,5))                                                 AS pv_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS net_pv_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS claim_fa_val,
CAST(0 AS DECIMAL(18,5))                                                 AS claim_net_fa_val
FROM (SELECT
coalesce(rtl.client_id, inv.client_id)                                   AS client_id,
coalesce(rtl.loc_sid_store, inv.loc_sid_store)                    AS loc_sid_store,
coalesce(rtl.src_orig_store_nr, inv.src_orig_store_nr)         AS src_orig_store_nr,
coalesce(rtl.src_wh_id, inv.src_wh_id)                             AS src_wh_id,
coalesce(rtl.dwh_cal_dt, inv.dwh_cal_dt)                          AS dwh_cal_dt,
coalesce(rtl.cy_month, inv.cy_month)                               AS cy_month,
coalesce(rtl.item_sid, inv.item_sid)                                   AS item_sid,
coalesce(rtl.retail_val, 0)                                                  AS retail_val,
coalesce(rtl.retail_net_val, 0)                                            AS retail_net_val,
coalesce(rtl.qty_act, 0)                                                     AS qty_act,
coalesce(inv.inv_diff_total_piece, 0)                                  AS diff_inv_stc_calc_cnt,
coalesce(inv.inv_diff_total_val, 0)                                      AS diff_inv_stc_calc_val,
coalesce(inv.inv_diff_total_net_val , 0)                               AS diff_inv_stc_calc_net_val
FROM p_lew_bil.t_agg_sales_retail_item_store_day_1           AS rtl
FULL OUTER JOIN p_lew_bil.t_agg_inv_item_store_day_1  AS inv
ON rtl.client_id                 = inv.client_id
AND rtl.loc_sid_store        = inv.loc_sid_store
AND rtl.item_sid                 = inv.item_sid
AND rtl.dwh_cal_dt             = inv.dwh_cal_dt
AND rtl.src_wh_id = inv.src_wh_id
) as rtl_inv
    /*    Rücksendungen/Reklamationen    */
FULL OUTER JOIN p_lew_bil.t_agg_inv_return_item_store_day_1 AS rtrn
ON  rtl_inv.client_id                 = rtrn.client_id
AND rtl_inv.loc_sid_store        = rtrn.loc_sid_store
AND rtl_inv.item_sid             = rtrn.item_sid
AND rtl_inv.dwh_cal_dt         = rtrn.dwh_cal_dt
AND rtl_inv.src_wh_id             =     rtrn.src_wh_id
) AS agg
;





