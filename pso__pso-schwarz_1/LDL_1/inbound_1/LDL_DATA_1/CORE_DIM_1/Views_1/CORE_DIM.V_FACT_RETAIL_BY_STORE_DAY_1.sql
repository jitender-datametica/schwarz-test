CREATE OR REPLACE VIEW CORE_DIM.V_FACT_RETAIL_BY_STORE_DAY_1(
 BUS_DT
,INT_ORG_SID
,INT_ORG_TYPE_CD
,COUNTRY_ORG_CD

,SALES_CNT
,SALES_BYTD_CNT
,SALES_PY_CNT
,SALES_PY_BYTD_CNT
,SALES_PY_SWDAY_CNT
,SALES_PY_SWDAY_BYTD_CNT
,SALES_QTY
,SALES_BYTD_QTY
,SALES_PY_QTY
,SALES_PY_BYTD_QTY
,SALES_PY_SWDAY_QTY
,SALES_PY_SWDAY_BYTD_QTY

,RETURN_CNT
,RETURN_BYTD_CNT
,RETURN_PY_CNT
,RETURN_PY_BYTD_CNT
,RETURN_PY_SWDAY_CNT
,RETURN_PY_SWDAY_BYTD_CNT
,RETURN_QTY
,RETURN_BYTD_QTY
,RETURN_PY_QTY
,RETURN_PY_BYTD_QTY
,RETURN_PY_SWDAY_QTY
,RETURN_PY_SWDAY_BYTD_QTY

,TOTAL_CNT
,TOTAL_BYTD_CNT
,TOTAL_PY_CNT
,TOTAL_PY_BYTD_CNT
,TOTAL_PY_SWDAY_CNT
,TOTAL_PY_SWDAY_BYTD_CNT
,TOTAL_QTY
,TOTAL_BYTD_QTY
,TOTAL_PY_QTY
,TOTAL_PY_BYTD_QTY
,TOTAL_PY_SWDAY_QTY
,TOTAL_PY_SWDAY_BYTD_QTY

,PERF_ADJ_SALES_CNT
,PERF_ADJ_SALES_BYTD_CNT
,PERF_ADJ_SALES_PY_CNT
,PERF_ADJ_SALES_PY_BYTD_CNT
,PERF_ADJ_SALES_PY_SWDAY_CNT
,PERF_ADJ_SALES_PY_SWDAY_BYTD_CNT
,PERF_ADJ_SALES_QTY
,PERF_ADJ_SALES_BYTD_QTY
,PERF_ADJ_SALES_PY_QTY
,PERF_ADJ_SALES_PY_BYTD_QTY
,PERF_ADJ_SALES_PY_SWDAY_QTY
,PERF_ADJ_SALES_PY_SWDAY_BYTD_QTY
,PERF_ADJ_RETURN_CNT
,PERF_ADJ_RETURN_BYTD_CNT
,PERF_ADJ_RETURN_PY_CNT
,PERF_ADJ_RETURN_PY_BYTD_CNT
,PERF_ADJ_RETURN_PY_SWDAY_CNT
,PERF_ADJ_RETURN_PY_SWDAY_BYTD_CNT
,PERF_ADJ_RETURN_QTY
,PERF_ADJ_RETURN_BYTD_QTY
,PERF_ADJ_RETURN_PY_QTY
,PERF_ADJ_RETURN_PY_BYTD_QTY
,PERF_ADJ_RETURN_PY_SWDAY_QTY
,PERF_ADJ_RETURN_PY_SWDAY_BYTD_QTY

,PERF_ADJ_TOTAL_CNT
,PERF_ADJ_TOTAL_BYTD_CNT
,PERF_ADJ_TOTAL_PY_CNT
,PERF_ADJ_TOTAL_PY_BYTD_CNT
,PERF_ADJ_TOTAL_PY_SWDAY_CNT
,PERF_ADJ_TOTAL_PY_SWDAY_BYTD_CNT
,PERF_ADJ_TOTAL_QTY
,PERF_ADJ_TOTAL_BYTD_QTY
,PERF_ADJ_TOTAl_PY_QTY
,PERF_ADJ_TOTAl_PY_BYTD_QTY
,PERF_ADJ_TOTAl_PY_SWDAY_QTY
,PERF_ADJ_TOTAL_PY_SWDAY_BYTD_QTY

,UOM_CD

,TURNOVER_NET_VAL
,TURNOVER_BYTD_NET_VAL
,TURNOVER_PY_NET_VAL
,TURNOVER_PY_BYTD_NET_VAL
,TURNOVER_PY_SWDAY_NET_VAL
,TURNOVER_PY_SWDAY_BYTD_NET_VAL


,PLAN_TURNOVER_NET_VAL
,PLAN_TURNOVER_BYTD_NET_VAL
,PLAN_TURNOVER_PY_NET_VAL
,PLAN_TURNOVER_PY_BYTD_NET_VAL
,PLAN_TURNOVER_PY_SWDAY_NET_VAL
,PLAN_TURNOVER_PY_SWDAY_BYTD_NET_VAL

,SALES_NET_VAL
,SALES_BYTD_NET_VAL
,SALES_PY_NET_VAL
,SALES_PY_BYTD_NET_VAL
,SALES_PY_SWDAY_NET_VAL
,SALES_PY_SWDAY_BYTD_NET_VAL
,RETURN_NET_VAL
,RETURN_BYTD_NET_VAL
,RETURN_PY_NET_VAL
,RETURN_PY_BYTD_NET_VAL
,RETURN_PY_SWDAY_NET_VAL
,RETURN_PY_SWDAY_BYTD_NET_VAL

,EOD_TURNOVER_NET_VAL
,BOOKED_TURNOVER_NET_VAL
,TURNOVER_GROSS_VAL
,TURNOVER_BYTD_GROSS_VAL
,TURNOVER_PY_GROSS_VAL
,TURNOVER_PY_BYTD_GROSS_VAL
,TURNOVER_PY_SWDAY_GROSS_VAL
,TURNOVER_PY_SWDAY_BYTD_GROSS_VAL
,CASH_REGISTER_SALES_GROSS_VAL
,CASH_REGISTER_RETURN_GROSS_VAL
,EOD_TURNOVER_GROSS_VAL
,CURR_CD
,RECEIPT_CNT
,RECEIPT_BYTD_CNT
,RECEIPT_PY_CNT
,RECEIPT_PY_BYTD_CNT
,RECEIPT_PY_SWDAY_CNT
,RECEIPT_PY_SWDAY_BYTD_CNT
,CASH_REGISTER_RECEIPT_CNT
,EOD_RECEIPT_CNT
,BOOKED_RECEIPT_CNT
,PLAN_RECEIPT_CNT
,PLAN_RECEIPT_BYTD_CNT
,PLAN_RECEIPT_PY_CNT
,PLAN_RECEIPT_PY_BYTD_CNT
,PLAN_RECEIPT_PY_SWDAY_CNT
,PLAN_RECEIPT_PY_SWDAY_BYTD_CNT
,DWH_CREATED_TMSP
,DWH_UPDATED_TMSP
,DWH_LOAD_ID
,DWH_NODE_CD
) AS
SELECT
    f.bus_dt
  , Coalesce(io.int_org_sid, pk.party_sid) AS int_org_sid
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.int_org_type_cd ELSE 'COMPANY' END AS int_org_type_cd
  , f.country_org_cd
  --SALES_1 CNT & QTY
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_cnt END AS sales_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_bytd_cnt END AS sales_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_py_cnt END AS sales_py_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_py_bytd_cnt END AS sales_py_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_py_swday_cnt END AS sales_py_swday_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_py_swday_bytd_cnt END AS sales_py_swday_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_qty END AS sales_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_bytd_qty END AS sales_bytd_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_py_qty END AS sales_py_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_py_bytd_qty END AS sales_py_bytd_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_py_swday_qty END AS sales_py_swday_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.sales_py_swday_bytd_qty END AS sales_py_swday_bytd_qty
    -- RETURN CNT & CNT
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_cnt END AS return_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_bytd_cnt END AS return_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_py_cnt END AS return_py_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_py_bytd_cnt END AS return_py_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_py_swday_cnt END AS return_py_swday_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_py_swday_bytd_cnt END AS return_py_swday_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_qty END AS return_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_bytd_qty END AS return_bytd_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_py_qty END AS return_py_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_py_bytd_qty END AS return_py_bytd_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_py_swday_qty END AS return_py_swday_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.return_py_swday_bytd_qty END AS return_py_swday_bytd_qty  
    -- TOTAL CNT & QTY
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_cnt, 0) + Coalesce(f.sales_cnt, 0) END AS total_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_bytd_cnt, 0) + Coalesce(f.sales_bytd_cnt, 0) END AS total_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_py_cnt, 0) + Coalesce(f.sales_py_cnt, 0) END AS total_py_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_py_bytd_cnt, 0) + Coalesce(f.sales_py_bytd_cnt, 0) END AS total_py_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_py_swday_cnt, 0) + Coalesce(f.sales_py_swday_cnt, 0) END AS total_py_swday_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_py_swday_bytd_cnt, 0) + Coalesce(f.sales_py_swday_bytd_cnt, 0) END AS total_py_swday_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_qty, 0) + Coalesce(f.sales_qty, 0) END AS total_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_bytd_qty, 0) + Coalesce(f.sales_bytd_qty, 0) END AS total_bytd_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_py_qty, 0) + Coalesce(f.sales_py_qty , 0) END AS total_py_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_py_bytd_qty, 0) + Coalesce(f.sales_py_bytd_qty , 0) END AS total_py_bytd_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_py_swday_qty, 0) + Coalesce(f.sales_py_swday_qty , 0) END AS total_py_swday_qty
  , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.return_py_swday_bytd_qty, 0) + Coalesce(f.sales_py_swday_bytd_qty , 0) END AS total_py_swday_bytd_qty  

-- PERF ADJ CNT & QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.perf_adj_sales_cnt END AS PERF_ADJ_SALES_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_BYTD_CNT END AS PERF_ADJ_SALES_BYTD_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_PY_CNT END AS PERF_ADJ_SALES_PY_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_PY_BYTD_CNT END AS PERF_ADJ_SALES_PY_BYTD_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_PY_SWDAY_CNT END AS PERF_ADJ_SALES_PY_SWDAY_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_PY_SWDAY_BYTD_CNT END AS PERF_ADJ_SALES_PY_SWDAY_BYTD_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_QTY END AS PERF_ADJ_SALES_QTY 
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_BYTD_QTY END AS ERF_ADJ_SALES_BYTD_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_PY_QTY END AS PERF_ADJ_SALES_PY_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_PY_BYTD_QTY END AS PERF_ADJ_SALES_PY_BYTD_QTY 
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_PY_SWDAY_QTY END AS PERF_ADJ_SALES_PY_SWDAY_QTY 
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_SALES_PY_SWDAY_BYTD_QTY END AS PERF_ADJ_SALES_PY_SWDAY_BYTD_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_CNT END AS PERF_ADJ_RETURN_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_BYTD_CNT END AS PERF_ADJ_RETURN_BYTD_CNT 
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_PY_CNT END AS PERF_ADJ_RETURN_PY_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_PY_BYTD_CNT END AS PERF_ADJ_RETURN_PY_BYTD_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_PY_SWDAY_CNT END AS ERF_ADJ_RETURN_PY_SWDAY_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_PY_SWDAY_BYTD_CNT END AS PERF_ADJ_RETURN_PY_SWDAY_BYTD_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_QTY END AS PERF_ADJ_RETURN_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_BYTD_QTY END AS PERF_ADJ_RETURN_BYTD_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_PY_QTY END AS PERF_ADJ_RETURN_PY_QTY 
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_PY_BYTD_QTY END AS PERF_ADJ_RETURN_PY_BYTD_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_PY_SWDAY_QTY END AS PERF_ADJ_RETURN_PY_SWDAY_QTY 
 , CASE WHEN io.int_org_sid IS NOT NULL THEN f.PERF_ADJ_RETURN_PY_SWDAY_BYTD_QTY END AS PERF_ADJ_RETURN_PY_SWDAY_BYTD_QTY

 --PERF ADJ CNT & QTY TOTALS 

 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_CNT, 0) + Coalesce(f.PERF_ADJ_RETURN_CNT, 0) END AS PERF_ADJ_TOTAL_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_BYTD_CNT, 0) + Coalesce(f.PERF_ADJ_RETURN_BYTD_CNT, 0) END AS PERF_ADJ_TOTAL_BYTD_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_PY_CNT, 0) + Coalesce(f.PERF_ADJ_RETURN_PY_CNT, 0) END AS PERF_ADJ_TOTAL_PY_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_PY_BYTD_CNT, 0) + Coalesce(f.PERF_ADJ_RETURN_PY_BYTD_CNT, 0) END AS PERF_ADJ_TOTAL_PY_BYTD_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_PY_SWDAY_CNT, 0) + Coalesce(f.PERF_ADJ_RETURN_PY_SWDAY_CNT, 0) END AS PERF_ADJ_TOTAL_PY_SWDAY_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_PY_SWDAY_BYTD_CNT, 0) + Coalesce(f.PERF_ADJ_RETURN_PY_SWDAY_BYTD_CNT , 0) END AS PERF_ADJ_TOTAL_PY_SWDAY_BYTD_CNT
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_QTY, 0) + Coalesce(f.PERF_ADJ_RETURN_QTY, 0) END AS PERF_ADJ_TOTAL_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_BYTD_QTY, 0) + Coalesce(f.PERF_ADJ_RETURN_BYTD_QTY, 0) END AS PERF_ADJ_TOTAL_BYTD_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_PY_QTY, 0) + Coalesce(f.PERF_ADJ_RETURN_PY_QTY, 0) END AS PERF_ADJ_TOTAL_PY_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_PY_BYTD_QTY, 0) + Coalesce(f.PERF_ADJ_RETURN_PY_BYTD_QTY , 0) END AS PERF_ADJ_TOTAL_PY_BYTD_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_PY_SWDAY_QTY, 0) + Coalesce(f.PERF_ADJ_RETURN_PY_SWDAY_QTY, 0) END AS PERF_ADJ_TOTAL_PY_SWDAY_QTY
 , CASE WHEN io.int_org_sid IS NOT NULL THEN Coalesce(f.PERF_ADJ_SALES_PY_SWDAY_BYTD_QTY, 0) + Coalesce(f.PERF_ADJ_RETURN_PY_SWDAY_BYTD_QTY, 0) END AS PERF_ADJ_TOTAL_PY_SWDAY_BYTD_QTY
 , f.UOM_CD

 -- TURNOVER NET 
  , f.turnover_net_val
  , f.turnover_bytd_net_val
  , f.turnover_py_net_val
  , f.turnover_py_bytd_net_val
  , f.turnover_py_swday_net_val
  , f.turnover_py_swday_bytd_net_val
 --Planned TURNOVER NET VAL 
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_turnover_net_val END AS plan_turnover_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_turnover_bytd_net_val END AS plan_turnover_bytd_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_turnover_py_net_val END AS plan_turnover_py_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_turnover_py_bytd_net_val END AS plan_turnover_py_bytd_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_turnover_py_swday_net_val END AS plan_turnover_py_swday_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_turnover_py_swday_bytd_net_val END AS plan_turnover_py_swday_bytd_net_val

  -- SALES_1 NET VAL
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_sales_net_val END AS sales_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_sales_bytd_net_val  END AS sales_bytd_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_sales_py_net_val  END AS sales_py_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_sales_py_bytd_net_val  END AS sales_py_bytd_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_sales_py_swday_net_val END AS sales_py_swday_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_sales_py_swday_bytd_net_val  END AS sales_py_swday_bytd_net_val

  -- RETURN NET VAL
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_return_net_val END AS return_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_return_bytd_net_val END AS return_bytd_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_return_py_net_val END AS return_py_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_return_py_bytd_net_val END AS return_py_bytd_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_return_py_swday_net_val END AS return_py_swday_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_return_py_swday_bytd_net_val END AS return_py_swday_bytd_net_val

  -- TURNOVER GROSS 

  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.eod_turnover_net_val END AS eod_turnover_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.booked_turnover_net_val END AS booked_turnover_net_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.turnover_gross_val END AS turnover_gross_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.turnover_bytd_gross_val END AS turnover_bytd_gross_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.turnover_py_gross_val END AS turnover_py_gross_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.turnover_py_bytd_gross_val END AS turnover_py_bytd_gross_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.turnover_py_swday_gross_val END AS turnover_py_swday_gross_val
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.turnover_py_swday_bytd_gross_val END AS turnover_py_swday_bytd_gross_val

  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.CASH_REGISTER_SALES_GROSS_VAL END AS CASH_REGISTER_SALES_GROSS_VAL
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.CASH_REGISTER_RETURN_GROSS_VAL END AS CASH_REGISTER_RETURN_GROSS_VAL
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.eod_turnover_gross_val END AS eod_turnover_gross_val
  , f.CURR_CD
  -- RECEIPT CNT
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.receipt_cnt END AS receipt_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.receipt_bytd_cnt END AS receipt_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.receipt_py_cnt END AS receipt_py_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.receipt_py_bytd_cnt END AS receipt_py_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.receipt_py_swday_cnt END AS receipt_py_swday_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.receipt_py_swday_bytd_cnt END AS receipt_py_swday_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.cash_register_receipt_cnt END AS cash_register_receipt_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.eod_receipt_cnt END AS eod_receipt_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.booked_receipt_cnt END AS booked_receipt_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_receipt_cnt END AS plan_receipt_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_receipt_bytd_cnt END AS plan_receipt_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_receipt_py_cnt END AS plan_receipt_py_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_receipt_py_bytd_cnt END AS plan_receipt_py_bytd_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_receipt_py_swday_cnt END AS plan_receipt_py_swday_cnt
  , CASE WHEN io.int_org_sid IS NOT NULL THEN f.plan_receipt_py_swday_bytd_cnt END AS plan_receipt_py_swday_bytd_cnt
  , f.dwh_created_tmsp
  , f.dwh_updated_tmsp
  , f.dwh_load_id
  , f.dwh_node_cd



FROM CORE_DIM.t_fact_retail_by_store_day_1 AS f
LEFT OUTER JOIN CORE_DIM.t_dim_internal_organization_1 AS io
ON  f.int_org_sid = io.int_org_sid
AND io.dwh_valid_fg
INNER JOIN META.t_party_key_1 AS pk
ON  f.country_org_cd = pk.party_nat_key_nr
AND pk.party_key_type_cd = 'COUNTRY_1'
AND pk.dwh_valid_fg;