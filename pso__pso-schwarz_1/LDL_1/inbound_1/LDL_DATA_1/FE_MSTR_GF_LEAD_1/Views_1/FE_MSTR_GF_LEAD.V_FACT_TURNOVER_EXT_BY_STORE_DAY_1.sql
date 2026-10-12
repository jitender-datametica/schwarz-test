CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_FACT_TURNOVER_EXT_BY_STORE_DAY_1
AS
SELECT
    b.bus_dt      AS cal_dt
  , b.int_org_sid AS store_sid
  , b.int_org_type_cd
  , b.country_org_cd
  , fer.src_curr_cd AS curr_cd
  , Decode(fer.src_curr_cd, 'EUR', 1, 0)                    AS curr_group_fg
  , Decode(fer.src_curr_cd, fer.tgt_curr_cd, 1, 0)          AS curr_local_fg

  , b.clean_fg                          AS bereinigt_fg
  , b.clean_py_swday_fg                 AS bereinigt_vjw_fg
  , b.clean_py_fg                       AS bereinigt_vjm_fg
  , b.clean_excl_opn_cls_wk_fg          AS bereinigt_excl_opn_cls_wk_fg
  , b.clean_excl_opn_cls_wk_py_swday_fg AS bereinigt_excl_opn_cls_wk_vjw_fg
  , b.clean_excl_opn_cls_wk_py_fg       AS bereinigt_excl_opn_cls_wk_vjm_fg

  , b.turnover_clean_net_val               / fer.exchange_rate AS turnover_net_val
  , b.turnover_clean_bytd_net_val          / fer.exchange_rate AS turnover_bytd_net_val
  , b.turnover_clean_py_net_val            / fer.exchange_rate AS turnover_py_net_val
  , b.turnover_clean_py_bytd_net_val       / fer.exchange_rate AS turnover_py_bytd_net_val
  , b.turnover_clean_py_swday_net_val      / fer.exchange_rate AS turnover_py_swday_net_val
  , b.turnover_clean_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val

  , b.receipt_clean_cnt               AS receipt_cnt
  , b.receipt_clean_bytd_cnt          AS receipt_bytd_cnt
  , b.receipt_clean_py_cnt            AS receipt_py_cnt
  , b.receipt_clean_py_bytd_cnt       AS receipt_py_bytd_cnt
  , b.receipt_clean_py_swday_cnt      AS receipt_py_swday_cnt
  , b.receipt_clean_py_swday_bytd_cnt AS receipt_py_swday_bytd_cnt

  , b.turnover_clean_excl_opn_cls_wk_net_val               / fer.exchange_rate AS turnover_ewk_net_val
  , b.turnover_clean_excl_opn_cls_wk_bytd_net_val          / fer.exchange_rate AS turnover_ewk_bytd_net_val
  , b.turnover_clean_excl_opn_cls_wk_py_net_val            / fer.exchange_rate AS turnover_ewk_py_net_val
  , b.turnover_clean_excl_opn_cls_wk_py_bytd_net_val       / fer.exchange_rate AS turnover_ewk_py_bytd_net_val
  , b.turnover_clean_excl_opn_cls_wk_py_swday_net_val      / fer.exchange_rate AS turnover_ewk_py_swday_net_val
  , b.turnover_clean_excl_opn_cls_wk_py_swday_bytd_net_val / fer.exchange_rate AS turnover_ewk_py_swday_bytd_net_val

  , b.receipt_clean_excl_opn_cls_wk_cnt               AS receipt_ewk_cnt
  , b.receipt_clean_excl_opn_cls_wk_bytd_cnt          AS receipt_ewk_bytd_cnt
  , b.receipt_clean_excl_opn_cls_wk_py_cnt            AS receipt_ewk_py_cnt
  , b.receipt_clean_excl_opn_cls_wk_py_bytd_cnt       AS receipt_ewk_py_bytd_cnt
  , b.receipt_clean_excl_opn_cls_wk_py_swday_cnt      AS receipt_ewk_py_swday_cnt
  , b.receipt_clean_excl_opn_cls_wk_py_swday_bytd_cnt AS receipt_ewk_py_swday_bytd_cnt

  , b.sales_variant_perf_total_cnt                               AS sales_variant_perf_total_cnt
  , b.sales_variant_perf_total_bytd_cnt                          AS sales_variant_perf_total_bytd_cnt
  , b.sales_variant_perf_total_py_cnt                            AS sales_variant_perf_total_py_cnt
  , b.sales_variant_perf_total_py_bytd_cnt                       AS sales_variant_perf_total_py_bytd_cnt
  , b.sales_variant_perf_total_py_swday_cnt                      AS sales_variant_perf_total_py_swday_cnt
  , b.sales_variant_perf_total_py_swday_bytd_cnt                 AS sales_variant_perf_total_py_swday_bytd_cnt
  , b.sales_variant_perf_total_excl_opn_cls_wk_cnt               AS sales_variant_perf_total_excl_opn_cls_wk_cnt
  , b.sales_variant_perf_total_excl_opn_cls_wk_bytd_cnt          AS sales_variant_perf_total_excl_opn_cls_wk_bytd_cnt
  , b.sales_variant_perf_total_excl_opn_cls_wk_py_cnt            AS sales_variant_perf_total_excl_opn_cls_wk_py_cnt
  , b.sales_variant_perf_total_excl_opn_cls_wk_py_bytd_cnt       AS sales_variant_perf_total_excl_opn_cls_wk_py_bytd_cnt
  , b.sales_variant_perf_total_excl_opn_cls_wk_py_swday_cnt      AS sales_variant_perf_total_excl_opn_cls_wk_py_swday_cnt
  , b.sales_variant_perf_total_excl_opn_cls_wk_py_swday_bytd_cnt AS sales_variant_perf_total_excl_opn_cls_wk_py_swday_bytd_cnt
  , b.sales_variant_perf_total_qty                               AS sales_variant_perf_total_qty
  , b.sales_variant_perf_total_bytd_qty                          AS sales_variant_perf_total_bytd_qty
  , b.sales_variant_perf_total_py_qty                            AS sales_variant_perf_total_py_qty
  , b.sales_variant_perf_total_py_bytd_qty                       AS sales_variant_perf_total_py_bytd_qty
  , b.sales_variant_perf_total_py_swday_qty                      AS sales_variant_perf_total_py_swday_qty
  , b.sales_variant_perf_total_py_swday_bytd_qty                 AS sales_variant_perf_total_py_swday_bytd_qty
  , b.sales_variant_perf_total_excl_opn_cls_wk_qty               AS sales_variant_perf_total_excl_opn_cls_wk_qty
  , b.sales_variant_perf_total_excl_opn_cls_wk_bytd_qty          AS sales_variant_perf_total_excl_opn_cls_wk_bytd_qty
  , b.sales_variant_perf_total_excl_opn_cls_wk_py_qty            AS sales_variant_perf_total_excl_opn_cls_wk_py_qty
  , b.sales_variant_perf_total_excl_opn_cls_wk_py_bytd_qty       AS sales_variant_perf_total_excl_opn_cls_wk_py_bytd_qty
  , b.sales_variant_perf_total_excl_opn_cls_wk_py_swday_qty      AS sales_variant_perf_total_excl_opn_cls_wk_py_swday_qty
  , b.sales_variant_perf_total_excl_opn_cls_wk_py_swday_bytd_qty AS sales_variant_perf_total_excl_opn_cls_wk_py_swday_bytd_qty

FROM core_dim.t_fact_turnover_clean_by_store_day AS b
INNER JOIN  CORE_DIM.t_fact_exchange_rate_1 AS fer
ON  b.curr_cd = fer.tgt_curr_cd
AND fer.exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE
;