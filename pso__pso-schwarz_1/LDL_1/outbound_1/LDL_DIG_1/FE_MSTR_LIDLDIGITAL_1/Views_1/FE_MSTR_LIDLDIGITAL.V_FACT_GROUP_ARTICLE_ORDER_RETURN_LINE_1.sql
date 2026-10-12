CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_group_article_order_return_line_1 AS WITH CTE_KEYS AS (SELECT
   cust_order_sid,
   cust_order_pos_nr,
   IF(bundle_header_pos_nr > 0, TRUE, FALSE) AS is_bundle_component_fg,
   FIRST_VALUE(prod_sid) OVER (PARTITION BY cust_order_nr, CAST(IF(is_bundle_header_fg = (1 <> 0), cust_order_pos_nr, bundle_header_pos_nr) AS STRING)
      ORDER BY cust_order_pos_nr IS NULL, cust_order_pos_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   AS group_header_prod_sid,
   FIRST_VALUE(prod_nr) OVER (PARTITION BY cust_order_nr, CAST(IF(is_bundle_header_fg = (1 <> 0), cust_order_pos_nr, bundle_header_pos_nr) AS STRING)
      ORDER BY cust_order_pos_nr IS NULL, cust_order_pos_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   AS group_header_prod_nr,
   FIRST_VALUE(prod_qty) OVER (PARTITION BY cust_order_nr, CAST(IF(is_bundle_header_fg = (1 <> 0), cust_order_pos_nr, bundle_header_pos_nr) AS STRING)
      ORDER BY cust_order_pos_nr IS NULL, cust_order_pos_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   AS group_header_qty
  FROM ldl_dig_lec_share.v_fact_customer_order_line_1
  WHERE is_bundle_header_fg
   OR bundle_header_pos_nr > 0) (-- Select only group article sales_1 & returns

  -- Flattening the table & group article hierarchy_1, by adding group header information on component lines

  /* RETURNS DATA */ SELECT /* ORDERS DATA */ V1.wshop_cd,
   V1.cust_order_dt,
   V1.cust_order_tm,
   V1.cust_order_nr,
   v0.cust_order_pos_nr,
   v0.group_header_prod_sid,
   v0.group_header_prod_nr,
   V1.prod_variant_sid,
   V1.prod_variant_nr,
   V1.prod_nr,
   V1.prod_qty,
   V1.curr_cd,
   V1.gc_lc_cd,
   V1.prod_price_net_val,
   V1.prod_price_net_eur_val,
   V1.prod_price_net_local_val,
   V1.prod_price_gross_val,
   V1.prod_price_gross_eur_val,
   V1.prod_price_gross_local_val,
   V1.prod_price_vat_val,
   V1.prod_price_vat_eur_val,
   V1.prod_price_vat_local_val,
   V1.ivp_price_net_val,
   V1.ivp_price_net_eur_val,
   V1.ivp_price_net_local_val,
   V1.cogs_price_net_val,
   V1.cogs_price_net_eur_val,
   V1.cogs_price_net_local_val,
   V1.tax_class_cd,
   V1.is_order_cancel_fg,
   V1.cust_order_type_cd,
   V1.sales_segment_type_cd,
   IF(v0.group_header_qty = 0, 0, SAFE_DIVIDE(V1.prod_qty, v0.group_header_qty)) AS group_component_base_qty,
   v2.cust_order_return_dt,
   v2.cust_order_return_nr,
   v2.cust_order_return_pos_nr,
   v2.cust_order_return_tm,
   v2.prod_return_reason_cd,
   v2.order_return_reason_cd,
   v2.return_prod_qty,
   v2.return_prod_price_net_val,
   v2.return_prod_price_net_eur_val,
   v2.return_prod_price_net_local_val,
   v2.return_prod_price_gross_val,
   v2.return_prod_price_gross_eur_val,
   v2.return_prod_price_gross_local_val,
   v2.return_prod_price_vat_val,
   v2.return_prod_price_vat_eur_val,
   v2.return_prod_price_vat_local_val,
   v2.return_ivp_price_net_val,
   v2.return_ivp_price_net_eur_val,
   v2.return_ivp_price_net_local_val
  FROM CTE_KEYS AS v0
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_fact_customer_order_line_1 AS V1 ON v0.cust_order_sid = V1.cust_order_sid AND
     v0.cust_order_pos_nr = V1.cust_order_pos_nr
   LEFT JOIN (SELECT cust_order_sid,
     cust_order_pos_nr,
     gc_lc_cd,
     MIN(cust_order_return_dt) AS cust_order_return_dt,
     MIN(cust_order_return_nr) AS cust_order_return_nr,
     MIN(cust_order_return_pos_nr) AS cust_order_return_pos_nr,
     MIN(cust_order_return_tm) AS cust_order_return_tm,
     MIN(prod_return_reason_cd) AS prod_return_reason_cd,
     MIN(order_return_reason_cd) AS order_return_reason_cd,
     SUM(return_prod_qty) AS return_prod_qty,
     SUM(return_prod_price_net_val) AS return_prod_price_net_val,
     SUM(return_prod_price_net_eur_val) AS return_prod_price_net_eur_val,
     SUM(prod_price_net_local_val) AS return_prod_price_net_local_val,
     SUM(return_prod_price_gross_val) AS return_prod_price_gross_val,
     SUM(return_prod_price_gross_eur_val) AS return_prod_price_gross_eur_val,
     SUM(prod_price_gross_local_val) AS return_prod_price_gross_local_val,
     SUM(return_prod_price_vat_val) AS return_prod_price_vat_val,
     SUM(return_prod_price_vat_eur_val) AS return_prod_price_vat_eur_val,
     SUM(prod_price_vat_local_val) AS return_prod_price_vat_local_val,
     SUM(ivp_price_net_val) AS return_ivp_price_net_val,
     SUM(ivp_price_net_eur_val) AS return_ivp_price_net_eur_val,
     SUM(ivp_price_net_local_val) AS return_ivp_price_net_local_val
    FROM ldl_dig_fe_mstr_lidldigital.v_fact_customer_order_line_return_1
    GROUP BY cust_order_sid,
     cust_order_pos_nr,
     gc_lc_cd) AS v2 ON v0.cust_order_sid = v2.cust_order_sid AND v0.cust_order_pos_nr = v2.cust_order_pos_nr AND V1.gc_lc_cd
      = v2.gc_lc_cd
  WHERE v0.is_bundle_component_fg);