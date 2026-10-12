CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_FACT_RETAIL_GROWTH_BY_STORE_DAY_EXCHANGE_RATE_TYPE_2(
	CAL_DT
	,STORE_SID
	,INT_ORG_TYPE_CD
	,COUNTRY_ORG_CD
	,EXCHANGE_RATE_TYPE_CD
	,EXCHANGE_BUS_YEAR
	,CURR_CD
	,CURR_GROUP_FG
	,CURR_LOCAL_FG
	,TURNOVER_NET_VAL
	,TURNOVER_BYTD_NET_VAL
	,TURNOVER_PY_NET_VAL
	,TURNOVER_PY_BYTD_NET_VAL
	,TURNOVER_PY_SWDAY_NET_VAL
	,TURNOVER_PY_SWDAY_BYTD_NET_VAL
	,RECEIPT_CNT
	,RECEIPT_BYTD_CNT
	,RECEIPT_PY_CNT
	,RECEIPT_PY_BYTD_CNT
	,RECEIPT_PY_SWDAY_CNT
	,RECEIPT_PY_SWDAY_BYTD_CNT
	,PERF_ADJ_TOTAL_CNT
	,PERF_ADJ_TOTAL_BYTD_CNT
	,PERF_ADJ_TOTAL_PY_CNT
	,PERF_ADJ_TOTAL_PY_BYTD_CNT
	,PERF_ADJ_TOTAL_PY_SWDAY_CNT
	,PERF_ADJ_TOTAL_PY_SWDAY_BYTD_CNT	
	,PERF_ADJ_TOTAL_QTY
	,PERF_ADJ_TOTAL_BYTD_QTY
	,PERF_ADJ_TOTAL_PY_QTY
	,PERF_ADJ_TOTAL_PY_BYTD_QTY
	,PERF_ADJ_TOTAL_PY_SWDAY_QTY
	,PERF_ADJ_TOTAL_PY_SWDAY_BYTD_QTY

) AS
SELECT
    b.bus_dt      AS cal_dt
  , b.int_org_sid AS store_sid
  , b.int_org_type_cd
  , b.country_org_cd
  , fer.exchange_rate_type_cd AS exchange_rate_type_cd
  , fer.bus_year AS exchange_bus_year
  , fer.src_curr_cd AS curr_cd
  , Decode(fer.src_curr_cd, 'EUR', 1, 0)                    AS curr_group_fg
  , Decode(fer.src_curr_cd, fer.tgt_curr_cd, 1, 0)          AS curr_local_fg

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


FROM CORE_DIM.V_FACT_RETAIL_GROWTH_BY_STORE_DAY_2 AS b
INNER JOIN CORE_DIM.T_FACT_EXCHANGE_RATE_2 AS fer
ON b.curr_cd = fer.tgt_curr_cd
WHERE (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
;