CREATE OR REPLACE VIEW ldl_data_production_etl.v_fact_retail_by_store_day_product (bus_dt, store_sid, prod_sid,
sales_variant_sid, country_org_sid, country_org_cd, sales_cnt, sales_qty, return_cnt, return_qty, perf_adj_sales_cnt,
perf_adj_sales_qty, perf_adj_return_cnt, perf_adj_return_qty, uom_cd, cash_register_sales_net_val,
cash_register_sales_gross_val, cash_register_return_net_val, cash_register_return_gross_val, curr_cd, dwh_created_tmsp,
dwh_updated_tmsp, dwh_load_id, dwh_node_cd) AS SELECT AGG.bus_dt,
 AGG.store_sid,
 COALESCE(prdvar.prod_sid, - 1) AS prod_sid,
 AGG.sales_variant_sid,
 AGG.country_org_sid,
 AGG.country_org_cd,
 AGG.sales_cnt,
 AGG.sales_qty,
 AGG.return_cnt,
 AGG.return_qty,
  CASE
  WHEN EXC.prod_sid IS NULL
  THEN AGG.perf_adj_sales_cnt
  ELSE NULL
  END AS perf_adj_sales_cnt,
  CASE
  WHEN EXC.prod_sid IS NULL
  THEN AGG.perf_adj_sales_qty
  ELSE NULL
  END AS perf_adj_sales_qty,
  CASE
  WHEN EXC.prod_sid IS NULL
  THEN AGG.perf_adj_return_cnt
  ELSE NULL
  END AS perf_adj_return_cnt,
  CASE
  WHEN EXC.prod_sid IS NULL
  THEN AGG.perf_adj_return_qty
  ELSE NULL
  END AS perf_adj_return_qty,
 AGG.uom_cd,
 AGG.sales_net_val AS cash_register_sales_net_val,
 AGG.sales_gross_val AS cash_register_sales_gross_val,
 AGG.return_net_val AS cash_register_return_net_val,
 AGG.return_gross_val AS cash_register_return_gross_val,
 AGG.curr_cd,
 CURRENT_TIMESTAMP() AS dwh_created_tmsp,
 CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
 1 AS dwh_load_id,
 'CORE_REL' AS dwh_node_cd
FROM (SELECT src.bus_dt,
   src.store_sid,
   src.prod_variant_sid AS sales_variant_sid,
   ANY_VALUE(src.country_org_sid) AS country_org_sid,
   ANY_VALUE(src.country_org_cd) AS country_org_cd,
   SUM(src.prod_variant_cnt) AS sales_variant_cnt,
   SUM(src.prod_variant_qty) AS sales_variant_qty,
   SUM(CASE
     WHEN src.prod_retail_line_type_cd IN ('S', 'SD', 'D', 'RD')
     THEN src.prod_variant_cnt
     ELSE NULL
     END) AS sales_cnt,
   SUM(CASE
     WHEN src.prod_retail_line_type_cd IN ('S', 'SD', 'D', 'RD')
     THEN src.prod_variant_qty
     ELSE NULL
     END) AS sales_qty,
   SUM(CASE
     WHEN src.prod_retail_line_type_cd IN ('S', 'SD', 'D', 'RD')
     THEN src.prod_variant_cnt
     ELSE NULL
     END) AS return_cnt,
   SUM(CASE
     WHEN src.prod_retail_line_type_cd IN ('S', 'SD', 'D', 'RD')
     THEN src.prod_variant_qty
     ELSE NULL
     END) AS return_qty,
   ANY_VALUE(COALESCE(src.uom_cd, '@')) AS uom_cd,
   SUM(CASE
     WHEN src.prod_retail_line_type_cd IN ('S', 'SD', 'D', 'RD')
     THEN src.retail_line_net_val
     ELSE NULL
     END) AS sales_net_val,
   SUM(CASE
     WHEN src.prod_retail_line_type_cd IN ('S', 'SD', 'D', 'RD')
     THEN src.retail_line_gross_val
     ELSE NULL
     END) AS sales_gross_val,
   SUM(CASE
     WHEN src.prod_retail_line_type_cd IN ('S', 'SD', 'D', 'RD')
     THEN src.retail_line_net_val
     ELSE NULL
     END) AS return_net_val,
   SUM(CASE
     WHEN src.prod_retail_line_type_cd IN ('S', 'SD', 'D', 'RD')
     THEN src.retail_line_gross_val
     ELSE NULL
     END) AS return_gross_val,
   ANY_VALUE(COALESCE(src.curr_cd, '@')) AS curr_cd,
   SUM(CASE
     WHEN (ABS(src.unit_price) / ((100 + src.tax_pct) / 100) / ER.exchange_rate) NOT BETWEEN 0.0001 AND 0.0315 AND src.prod_retail_line_type_cd
        IN ('S', 'SD', 'D', 'RD')
     THEN src.prod_variant_cnt
     ELSE 0
     END) AS perf_adj_sales_cnt,
   SUM(CASE
     WHEN (ABS(src.unit_price) / ((100 + src.tax_pct) / 100) / ER.exchange_rate) NOT BETWEEN 0.0001 AND 0.0315 AND src.prod_retail_line_type_cd
        IN ('S', 'SD', 'D', 'RD')
     THEN src.prod_variant_cnt
     ELSE 0
     END) AS perf_adj_return_cnt,
   SUM(CASE
     WHEN (ABS(src.unit_price) / ((100 + src.tax_pct) / 100) / ER.exchange_rate) NOT BETWEEN 0.0001 AND 0.0315 AND src.prod_retail_line_type_cd
        IN ('S', 'SD', 'D', 'RD')
     THEN src.prod_variant_qty
     ELSE 0
     END) AS perf_adj_sales_qty,
   SUM(CASE
     WHEN (ABS(src.unit_price) / ((100 + src.tax_pct) / 100) / ER.exchange_rate) NOT BETWEEN 0.0001 AND 0.0315 AND src.prod_retail_line_type_cd
        IN ('S', 'SD', 'D', 'RD')
     THEN src.prod_variant_qty
     ELSE 0
     END) AS perf_adj_return_qty
  FROM ldl_data_production_core_rel.t_product_retail_line AS src
   INNER JOIN (SELECT tgt_curr_cd,
     exchange_rate
    FROM ldl_data_production_core_rel.t_exchange_rate
    WHERE exchange_rate_type_cd = 'BEW_ISK'
     AND src_curr_cd = 'EUR'
     AND dwh_valid_fg) AS ER ON src.curr_cd = ER.tgt_curr_cd
  WHERE src.turnover_relevant_fg
   AND src.bus_dt BETWEEN CAST($min_dwh_cal_dt AS DATE) AND (CAST($max_dwh_cal_dt AS DATE))
  GROUP BY src.bus_dt,
   src.store_sid,
   sales_variant_sid) AS AGG
 LEFT JOIN ldl_data_production_core_rel.t_product_variant AS prdvar ON AGG.sales_variant_sid = prdvar.prod_variant_sid
  AND prdvar.dwh_valid_fg
 LEFT JOIN (SELECT DISTINCT ppg.prod_sid
  FROM ldl_data_production_core_rel.t_product_to_product_group AS ppg
   INNER JOIN ldl_data_production_core_rel.t_product_group_hierarchy AS pgh1 ON ppg.dwh_valid_fg AND ppg.prod_grp_type_cd
         = 'IFG' AND ppg.prod_grp_sid = pgh1.prod_grp_sid AND pgh1.prod_grp_hierarchy_type_cd = 'IGH' AND pgh1.dwh_valid_fg
    
   INNER JOIN ldl_data_production_core_rel.t_product_group AS sig ON pgh1.parent_prod_grp_sid = sig.prod_grp_sid AND sig
    .dwh_valid_fg
   LEFT JOIN ldl_data_production_core_rel.t_product_group_hierarchy AS pgh2 ON pgh1.parent_prod_grp_sid = pgh2.prod_grp_sid
       AND pgh2.prod_grp_hierarchy_type_cd = 'IGH' AND pgh2.dwh_valid_fg
   LEFT JOIN ldl_data_production_core_rel.t_product_group AS igi ON pgh2.parent_prod_grp_sid = igi.prod_grp_sid AND igi
    .dwh_valid_fg
  WHERE igi.prod_grp_sid IS NULL
   AND ROUND(SAFE_CAST(sig.prod_grp_nr AS BIGNUMERIC), 0) <> 991
    /* Ignore all except commissions from the ""Admin"" group */) AS EXC ON prdvar.prod_sid = EXC.prod_sid;