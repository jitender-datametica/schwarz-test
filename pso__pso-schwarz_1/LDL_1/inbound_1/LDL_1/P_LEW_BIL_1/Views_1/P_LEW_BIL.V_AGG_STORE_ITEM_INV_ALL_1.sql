CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_STORE_ITEM_INV_ALL_1
/*
#DescStart#
#$Revision: 16398 $, $LastChangedBy: mlysik $
#SubjectAreas#: Inventuren
#DescEnd# 
*/
(
     client_id
,          store_id
,          inv_id
,          cy_month
,          dat_valid_from
,          dat_valid_until
,          item_id
,          val_rtl_ejr
,          val_rtl_net_ejr
,          val_return_ejr
,          val_return_net_ejr
,          qty_piece_ejr
,          qty_return_ejr
,          diff_inv_stc_calc_cnt
,          diff_inv_stc_calc_price_avg
,          diff_inv_stc_calc_prc_avg_net
,          diff_inv_stc_calc_val
,          diff_inv_stc_calc_val_net
,          diff_inv_stc_calc_val_net_diff
,          val_abs
,          val_net_abs
,          val_pr_diff_del
,          val_pr_diff_net_del
,          val_pr_diff_return
,          val_pr_diff_net_return
,          val_pv
,          val_net_pv
,          val_claim
,          val_claim_net
,          val_rtl_fa_ejr
,          val_rtl_net_fa_ejr
,          val_return_fa_ejr
,          val_return_net_fa_ejr
,          qty_piece_fa_ejr
,          qty_return_fa_ejr
,          diff_inv_stc_calc_cnt_fa
,          diff_inv_stc_calc_val_fa
,          diff_inv_stc_calc_val_net_fa
,          val_abs_fa
,          val_net_abs_fa
,          val_pr_diff_fa_del
,          val_pr_diff_net_fa_del
,          val_pr_diff_fa_return
,          val_pr_diff_net_fa_return
,          val_pv_fa
,          val_net_pv_fa
,          val_claim_fa
,          val_claim_net_fa
)
AS
(SELECT
Agg.client_id,
Agg.st_loc_sid                                           AS store_id,
Agg.inv_id,
Agg.cy_month,
Agg.dat_valid_from,
Agg.dat_valid_until,
Agg.item_sid                                             AS item_id,
Agg.val_rtl_ejr,
Agg.val_rtl_net_ejr,
Agg.val_return_ejr,
Agg.val_return_net_ejr,
Agg.qty_piece_ejr,
Agg.qty_return_ejr,
Agg.diff_inv_stc_calc_cnt,
                       Agg.diff_inv_stc_calc_val / CASE
   WHEN Agg.diff_inv_stc_calc_cnt <> 0 THEN Agg.diff_inv_stc_calc_cnt
 END                          AS diff_inv_stc_calc_price_avg,
                          Agg.diff_inv_stc_calc_net_val / CASE
   WHEN Agg.diff_inv_stc_calc_cnt <> 0 THEN Agg.diff_inv_stc_calc_cnt
 END                      AS diff_inv_stc_calc_prc_avg_net,
Agg.diff_inv_stc_calc_val,
Agg.diff_inv_stc_calc_net_val,
Agg.diff_inv_stc_calc_net_val_diff,
Agg.val_abs,
Agg.val_net_abs,
Agg.val_pr_diff_del,
Agg.val_pr_diff_net_del,
Agg.val_pr_diff_return,
Agg.val_pr_diff_net_return,
Agg.val_pv,
Agg.val_net_pv,
Agg.val_claim,
Agg.val_claim_net,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_rtl_ejr               END AS val_rtl_fa_ejr,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_rtl_net_ejr           END AS val_rtl_net_fa_ejr,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_return_ejr            END AS val_return_fa_ejr,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_return_net_ejr        END AS val_return_net_fa_ejr,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.qty_piece_ejr             END AS qty_piece_fa_ejr,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.qty_return_ejr            END AS qty_return_fa_ejr,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.diff_inv_stc_calc_cnt     END AS diff_inv_stc_calc_cnt_fa,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.diff_inv_stc_calc_val     END AS diff_inv_stc_calc_val_fa,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.diff_inv_stc_calc_net_val END AS diff_inv_stc_calc_net_val_fa,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_abs                   END AS val_abs_fa,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_net_abs               END AS val_net_abs_fa,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_pr_diff_del           END AS val_pr_diff_fa_del,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_pr_diff_net_del       END AS val_pr_diff_net_fa_del,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_pr_diff_return        END AS val_pr_diff_fa_return,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_pr_diff_net_return    END AS val_pr_diff_net_fa_return,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_pv                    END AS val_pv_fa,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_net_pv                END AS val_net_pv_fa,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_claim                 END AS val_claim_fa,
CASE WHEN Agg.foodaction_fg_asis = 1 THEN Agg.val_claim_net             END AS val_claim_net_fa
FROM p_lew_bil.t_agg_store_item_inv_all_1    AS Agg
UNION ALL
SELECT
Agg.client_id,
Agg.loc_sid_store                                                                          AS store_id,
CAST(1 AS INTEGER)                                                                         AS inv_id,
Agg.cy_month                                                                               AS cy_month,
Agg.dwh_cal_dt                                                                             AS dat_valid_from,
Agg.dwh_cal_dt                                                                             AS dat_valid_until,
Agg.item_sid                                                                               AS item_id,
Coalesce(Agg.retail_val         ,0)                                                        AS val_rtl_ejr,
Coalesce(Agg.retail_net_val     ,0)                                                        AS val_rtl_net_ejr,
CAST(0 AS DECIMAL(18,4))                                                                   AS val_return_ejr,
CAST(0 AS DECIMAL(18,4))                                                                   AS val_return_net_ejr,
Agg.qty_act                                                                                AS qty_piece_ejr,
CAST(0 AS DECIMAL(18,4))                                                                   AS qty_return_ejr,
Coalesce(Agg.diff_inv_stc_calc_cnt    , 0) + Coalesce(Agg.diff_inv_return_qty    , 0)      AS diff_inv_stc_calc_cnt,
Cast(NULL AS DECIMAL(18,4))                                                                AS diff_inv_stc_calc_price_avg,
Cast(NULL AS DECIMAL(18,4))                                                                AS diff_inv_stc_calc_prc_avg_net,
(Coalesce(Agg.diff_inv_stc_calc_val    , 0) + Coalesce(Agg.diff_inv_return_val    , 0))    AS diff_inv_stc_calc_val,
(Coalesce(Agg.diff_inv_stc_calc_net_val, 0) + Coalesce(Agg.diff_inv_return_net_val, 0))    AS diff_inv_stc_calc_val_net,
Cast(NULL AS DECIMAL(18,4))                                                                AS diff_inv_stc_calc_net_val_diff,
Agg.abs_val                                                                               AS val_abs,
Agg.net_abs_val                                                                           AS val_net_abs,
Agg.pr_diff_del_val                                                                       AS val_pr_diff_del,
Agg.pr_diff_net_del_val                                                                   AS val_pr_diff_net_del,
Agg.pr_diff_return_val                                                                    AS val_pr_diff_return,
Agg.pr_diff_net_return_val                                                                AS val_pr_diff_net_return,
Agg.pv_val                                                                                AS val_pv,
Agg.net_pv_val                                                                            AS val_net_pv,
Agg.claim_val                                                                             AS val_claim,
Agg.claim_net_val                                                                         AS val_claim_net,
Agg.retail_fa_val                                                                         AS val_rtl_fa_ejr,
Agg.retail_net_fa_val                                                                     AS val_rtl_net_fa_ejr,
Agg.return_fa_val                                                                         AS val_return_fa_ejr,
Agg.return_net_fa_val                                                                     AS val_return_net_fa_ejr,
Agg.qty_piece_fa                                                                          AS qty_piece_fa_ejr,
Agg.qty_return_fa                                                                         AS qty_return_fa_ejr,
Agg.diff_inv_stc_calc_cnt_fa                                                              AS diff_inv_stc_calc_cnt_fa,
Agg.diff_inv_stc_calc_val_fa                                                              AS diff_inv_stc_calc_val_fa,
Agg.diff_inv_stc_calc_net_val_fa                                                          AS diff_inv_stc_calc_val_net_fa,
Agg.abs_fa_val                                                                            AS val_abs_fa,
Agg.net_abs_fa_val                                                                        AS val_net_abs_fa,
Agg.pr_diff_fa_del_val                                                                    AS val_pr_diff_fa_del,
Agg.pr_diff_net_fa_del_val                                                                AS val_pr_diff_net_fa_del,
Agg.pr_diff_fa_return_val                                                                 AS val_pr_diff_fa_return,
Agg.pr_diff_net_fa_return_val                                                             AS val_pr_diff_net_fa_return,
Agg.pv_fa_val                                                                             AS val_pv_fa,
Agg.net_pv_fa_val                                                                         AS val_net_pv_fa,
Agg.claim_fa_val                                                                          AS val_claim_fa,
Agg.claim_net_fa_val                                                                      AS val_claim_net_fa
FROM p_lew_bil.t_agg_item_store_day_1    AS Agg
)
;
