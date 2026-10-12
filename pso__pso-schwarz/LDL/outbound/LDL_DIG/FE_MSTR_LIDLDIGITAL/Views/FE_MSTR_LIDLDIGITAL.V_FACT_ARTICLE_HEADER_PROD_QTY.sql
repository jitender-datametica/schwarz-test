CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_article_header_prod_qty (prod_variant_sid, cust_order_sid,
cust_order_dt, wshop_cd, prod_qty) AS SELECT COL_FACT_2.prod_variant_sid,
 IFNULL(COL_FACT.cust_order_sid, - 1) AS cust_order_sid,
 COL_FACT.cust_order_dt,
  CASE
  WHEN COL_FACT.wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(COL_FACT.wshop_cd, '-1')
  END AS wshop_cd,
 SUM(COL_FACT.prod_qty) AS prod_qty
FROM ldl_dig_lec_share.v_fact_customer_order_line AS COL_FACT
 INNER JOIN ldl_dig_lec_share.v_fact_customer_order_line AS COL_FACT_2 ON COL_FACT.cust_order_sid = COL_FACT_2.cust_order_sid
    AND COL_FACT.cust_order_pos_nr = COL_FACT_2.bundle_header_pos_nr
WHERE COL_FACT.is_bundle_header_fg
 AND NOT COL_FACT_2.is_bundle_header_fg
GROUP BY COL_FACT_2.prod_variant_sid,
 COL_FACT.cust_order_sid,
 COL_FACT.cust_order_dt,
 COL_FACT.wshop_cd;