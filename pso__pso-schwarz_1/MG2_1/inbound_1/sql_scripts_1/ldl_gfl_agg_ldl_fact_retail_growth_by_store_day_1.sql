!SET exit_on_error=True;

BEGIN WORK;

DELETE FROM core_dim.t_fact_retail_growth_by_store_day_1;

INSERT INTO core_dim.t_fact_retail_growth_by_store_day_1
(
	bus_dt,
	int_org_sid,
	int_org_type_cd,
	country_org_cd,
	perf_adj_sales_cnt,
	perf_adj_sales_bytd_cnt,
	perf_adj_sales_py_cnt,
	perf_adj_sales_py_bytd_cnt,
	perf_adj_sales_py_swday_cnt,
	perf_adj_sales_py_swday_bytd_cnt,
	perf_adj_sales_qty,
	perf_adj_sales_bytd_qty,
	perf_adj_sales_py_qty,
	perf_adj_sales_py_bytd_qty,
	perf_adj_sales_py_swday_qty,
	perf_adj_sales_py_swday_bytd_qty,
	perf_adj_return_cnt,
	perf_adj_return_bytd_cnt,
	perf_adj_return_py_cnt,
	perf_adj_return_py_bytd_cnt,
	perf_adj_return_py_swday_cnt,
	perf_adj_return_py_swday_bytd_cnt,
	perf_adj_return_qty,
	perf_adj_return_bytd_qty,
	perf_adj_return_py_qty,
	perf_adj_return_py_bytd_qty,
	perf_adj_return_py_swday_qty,
	perf_adj_return_py_swday_bytd_qty,
	uom_cd,
	turnover_net_val,
	turnover_bytd_net_val,
	turnover_py_net_val,
	turnover_py_bytd_net_val,
	turnover_py_swday_net_val,
	turnover_py_swday_bytd_net_val,
	curr_cd,
	receipt_cnt,
	receipt_bytd_cnt,
	receipt_py_cnt,
	receipt_py_bytd_cnt,
	receipt_py_swday_cnt,
	receipt_py_swday_bytd_cnt,
	dwh_created_tmsp,
	dwh_updated_tmsp,
	dwh_load_id,
	dwh_node_cd
)
SELECT 
 tf.BUS_DT
,tf.INT_ORG_SID
,tf.INT_ORG_TYPE_CD
,tf.COUNTRY_ORG_CD

-- PERF_ADJ_SALES_CNT
,PERF_ADJ_SALES_CNT * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END AS PERF_ADJ_SALES_CNT
,SUM (PERF_ADJ_SALES_CNT * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END)
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS PERF_ADJ_SALES_BYTD_CNT                        
,PERF_ADJ_SALES_PY_CNT * relevant_for_comp_py_fg::NUMBER AS PERF_ADJ_SALES_PY_CNT
,SUM (PERF_ADJ_SALES_PY_CNT  * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END) 
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS PERF_ADJ_SALES_PY_BYTD_CNT

,PERF_ADJ_SALES_PY_SWDAY_CNT * CASE WHEN relevant_for_comp_py_swday_fg then 1 else 0 end AS PERF_ADJ_SALES_PY_SWDAY_CNT

,SUM (PERF_ADJ_SALES_PY_SWDAY_CNT  * CASE WHEN relevant_for_comp_py_swday_fg  THEN 1 ELSE 0 END) 
                        OVER   (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS PERF_ADJ_SALES_PY_SWDAY_BYTD_CNT

-- PERF_ADJ_SALES_QTY
,PERF_ADJ_SALES_QTY * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END AS PERF_ADJ_SALES_QTY 
,SUM (PERF_ADJ_SALES_QTY * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END  )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS PERF_ADJ_SALES_BYTD_QTY
,PERF_ADJ_SALES_PY_QTY * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END AS PERF_ADJ_SALES_PY_QTY

, SUM (PERF_ADJ_SALES_PY_QTY * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END  )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS PERF_ADJ_SALES_PY_BYTD_QTY



,PERF_ADJ_SALES_PY_SWDAY_QTY * case when relevant_for_comp_py_swday_fg then 1 else 0 end AS PERF_ADJ_SALES_PY_SWDAY_QTY

, SUM (PERF_ADJ_SALES_PY_SWDAY_QTY * CASE WHEN relevant_for_comp_py_swday_fg THEN 1 ELSE 0 END  )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS PERF_ADJ_SALES_PY_SWDAY_BYTD_QTY 



-- PERF_ADJ_RETURN_CNT 
,PERF_ADJ_RETURN_CNT * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END AS PERF_ADJ_RETURN_CNT
,SUM (PERF_ADJ_RETURN_CNT * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END  )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS PERF_ADJ_RETURN_BYTD_CNT

,PERF_ADJ_RETURN_PY_CNT * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END AS PERF_ADJ_RETURN_PY_CNT

,SUM (PERF_ADJ_RETURN_PY_CNT * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END  )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS PERF_ADJ_RETURN_PY_BYTD_CNT 

,PERF_ADJ_RETURN_PY_SWDAY_CNT * case when relevant_for_comp_py_swday_fg then 1 else 0 end AS PERF_ADJ_RETURN_PY_SWDAY_CNT 

,SUM (PERF_ADJ_RETURN_PY_SWDAY_CNT   * case when relevant_for_comp_py_swday_fg  THEN 1 ELSE 0 END )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS PERF_ADJ_RETURN_PY_SWDAY_BYTD_CNT


-- PERF_ADJ_RETURN_QTY
, PERF_ADJ_RETURN_QTY * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END AS PERF_ADJ_RETURN_QTY
, SUM (PERF_ADJ_RETURN_QTY * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS PERF_ADJ_RETURN_BYTD_QTY 


, PERF_ADJ_RETURN_PY_QTY * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END AS PERF_ADJ_RETURN_PY_QTY

, SUM (PERF_ADJ_RETURN_PY_QTY * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END)
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS PERF_ADJ_RETURN_PY_BYTD_QTY

, PERF_ADJ_RETURN_PY_SWDAY_QTY * case when relevant_for_comp_py_swday_fg then 1 else 0 end

, SUM (PERF_ADJ_RETURN_PY_SWDAY_QTY * case when relevant_for_comp_py_swday_fg  THEN 1 ELSE 0 END)
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS PERF_ADJ_RETURN_PY_SWDAY_BYTD_QTY
, COALESCE (UOM_CD, '@' ) AS UOM_CD
-- TURNOVER_NET_VAL
, TURNOVER_NET_VAL * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END AS TURNOVER_NET_VAL 
, SUM (TURNOVER_NET_VAL * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS TURNOVER_BYTD_NET_VAL
, TURNOVER_PY_NET_VAL * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END
, SUM (TURNOVER_PY_NET_VAL * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END)
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TURNOVER_PY_BYTD_NET_VAL 
, TURNOVER_PY_SWDAY_NET_VAL * case when relevant_for_comp_py_swday_fg then 1 else 0 end
, SUM (TURNOVER_PY_SWDAY_NET_VAL * case when relevant_for_comp_py_swday_fg then 1 else 0 end)
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TURNOVER_PY_SWDAY_BYTD_NET_VAL
, CURR_CD
--RECEIPT_CNT
, RECEIPT_CNT * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END AS RECEIPT_CNT
,  SUM (RECEIPT_CNT * CASE WHEN relevant_for_comp_fg THEN 1 ELSE 0 END )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RECEIPT_BYTD_CNT
, RECEIPT_PY_CNT * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END

, SUM (RECEIPT_PY_CNT * CASE WHEN relevant_for_comp_py_fg THEN 1 ELSE 0 END )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS  RECEIPT_PY_BYTD_CNT 
, RECEIPT_PY_SWDAY_CNT * case when relevant_for_comp_py_swday_fg then 1 else 0 end

, SUM (RECEIPT_PY_SWDAY_CNT * case when relevant_for_comp_py_swday_fg then 1 else 0 end )
                                  OVER  (PARTITION BY tf.INT_ORG_SID,cal.bus_year ORDER BY tf.bus_dt ASC
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RECEIPT_PY_SWDAY_BYTD_CNT 
,tf.DWH_CREATED_TMSP
,tf.DWH_UPDATED_TMSP
,tf.DWH_LOAD_ID
,tf.DWH_NODE_CD

from core_dim.t_fact_retail_by_store_day_1 as tf
JOIN core_dim.t_fact_store_open_days_1 as tfs 
ON tf.int_org_sid = tfs.store_sid
AND tf.bus_dt = tfs.bus_dt
JOIN core_dim.t_dim_calendar_month_1 cal
ON tf.bus_dt between cal.cal_month_begin_dt and cal.cal_month_end_dt
ORDER BY tf.COUNTRY_ORG_CD,tf.BUS_DT;

COMMIT;
