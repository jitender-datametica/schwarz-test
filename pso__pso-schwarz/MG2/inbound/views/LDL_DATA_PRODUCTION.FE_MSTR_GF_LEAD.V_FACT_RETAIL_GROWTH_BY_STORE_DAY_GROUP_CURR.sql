create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_RETAIL_GROWTH_BY_STORE_DAY_GROUP_CURR(
	CAL_DT,
	STORE_SID,
	INT_ORG_TYPE_CD,
	COUNTRY_ORG_CD,
	CURR_CD,
	CURR_GROUP_FG,
	CURR_LOCAL_FG,
	TURNOVER_NET_VAL,
	TURNOVER_BYTD_NET_VAL,
	TURNOVER_PY_NET_VAL,
	TURNOVER_PY_BYTD_NET_VAL,
	TURNOVER_PY_SWDAY_NET_VAL,
	TURNOVER_PY_SWDAY_BYTD_NET_VAL,
	RECEIPT_CNT,
	RECEIPT_BYTD_CNT,
	RECEIPT_PY_CNT,
	RECEIPT_PY_BYTD_CNT,
	RECEIPT_PY_SWDAY_CNT,
	RECEIPT_PY_SWDAY_BYTD_CNT,
	PERF_ADJ_TOTAL_CNT,
	PERF_ADJ_TOTAL_BYTD_CNT,
	PERF_ADJ_TOTAL_PY_CNT,
	PERF_ADJ_TOTAL_PY_BYTD_CNT,
	PERF_ADJ_TOTAL_PY_SWDAY_CNT,
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_CNT,
	PERF_ADJ_TOTAL_QTY,
	PERF_ADJ_TOTAL_BYTD_QTY,
	PERF_ADJ_TOTAL_PY_QTY,
	PERF_ADJ_TOTAL_PY_BYTD_QTY,
	PERF_ADJ_TOTAL_PY_SWDAY_QTY,
	PERF_ADJ_TOTAL_PY_SWDAY_BYTD_QTY
) as
SELECT
    b.bus_dt      AS cal_dt
  , b.int_org_sid AS store_sid
  , b.int_org_type_cd
  , b.country_org_cd
  , fer.src_curr_cd AS curr_cd
  , DECODE(fer.src_curr_cd, 'EUR', 1, 0)                    AS curr_group_fg
  , DECODE(fer.src_curr_cd, fer.tgt_curr_cd, 1, 0)          AS curr_local_fg

  , b.turnover_net_val               / fer.exchange_rate AS turnover_net_val
  , b.turnover_bytd_net_val          / fer.exchange_rate AS turnover_bytd_net_val
  , b.turnover_py_net_val            / fer.exchange_rate AS turnover_py_net_val
  , b.turnover_py_bytd_net_val       / fer.exchange_rate AS turnover_py_bytd_net_val
  , b.turnover_py_swday_net_val      / fer.exchange_rate AS turnover_py_swday_net_val
  , b.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val

  , b.receipt_cnt               AS receipt_cnt
  , b.receipt_bytd_cnt          AS receipt_bytd_cnt
  , b.receipt_py_cnt            AS receipt_py_cnt
  , b.receipt_py_bytd_cnt       AS receipt_py_bytd_cnt
  , b.receipt_py_swday_cnt      AS receipt_py_swday_cnt
  , b.receipt_py_swday_bytd_cnt AS receipt_py_swday_bytd_cnt

  , b.perf_adj_total_cnt                               AS perf_adj_total_cnt
  , b.perf_adj_total_bytd_cnt                          AS perf_adj_total_bytd_cnt
  , b.perf_adj_total_py_cnt                            AS perf_adj_total_py_cnt
  , b.perf_adj_total_py_bytd_cnt                       AS perf_adj_total_py_bytd_cnt
  , b.perf_adj_total_py_swday_cnt                      AS perf_adj_total_py_swday_cnt
  , b.perf_adj_total_py_swday_bytd_cnt                 AS perf_adj_total_py_swday_bytd_cnt
  , CASE WHEN b.country_org_cd = 'US' THEN b.perf_adj_total_qty*0.453592 ELSE b.perf_adj_total_qty END AS perf_adj_total_qty
  , CASE WHEN b.country_org_cd = 'US' THEN b.perf_adj_total_bytd_qty*0.453592 ELSE b.perf_adj_total_bytd_qty END AS perf_adj_total_bytd_qty
  , CASE WHEN b.country_org_cd = 'US' THEN b.perf_adj_total_py_qty*0.453592 ELSE b.perf_adj_total_py_qty END AS perf_adj_total_py_qty
  , CASE WHEN b.country_org_cd = 'US' THEN b.perf_adj_total_py_bytd_qty*0.453592 ELSE b.perf_adj_total_py_bytd_qty END AS perf_adj_total_py_bytd_qty
  , CASE WHEN b.country_org_cd = 'US' THEN b.perf_adj_total_py_swday_qty*0.453592 ELSE b.perf_adj_total_py_swday_qty END AS perf_adj_total_py_swday_qty
  , CASE WHEN b.country_org_cd = 'US' THEN b.perf_adj_total_py_swday_bytd_qty*0.453592 ELSE b.perf_adj_total_py_swday_bytd_qty END AS perf_adj_total_py_swday_bytd_qty

FROM CORE_DIM.V_FACT_RETAIL_GROWTH_BY_STORE_DAY AS b
INNER JOIN CORE_DIM.T_FACT_EXCHANGE_RATE AS fer
ON b.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR')
AND fer.active_fg = TRUE
;