CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_sales_promotion_2 AS SELECT promo_id,
  CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
 IFNULL(prod_sid, -1) AS prod_sid,
 promo_nr,
  CASE
  WHEN sale_promo_type_cd = ''
  THEN '-1'
  ELSE IFNULL(sale_promo_type_cd, '-1')
  END AS sale_promo_type_cd,
 promo_dur_week_cnt,
 is_repeated_fg,
 amc_ian_nr,
 supplier_order_qty,
 first_week_start_dt,
 analysis_start_dt,
 analysis_end_dt,
 promo_descr,
 tgt_prod_sale_qty,
 promo_start_dt,
 promo_sale_start_dt,
 is_catalog_prod_fg,
 first_delivery_cy_week,
 tgt_prod_receive_cy_week,
 is_tv_promo_fg,
 assortment_plan_period_nr,
 prod_nr,
 return_cond_descr,
 sale_promo_status_cd
FROM ldl_dig_lec_share.v_dim_sales_promotion_2
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '-1' AS dm__operand1,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand2,
 '0' AS dm__operand3,
 '-1' AS dm__operand4,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand5,
 CAST('FALSE' AS BOOL) AS dm__operand6,
 '0' AS dm__operand7,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand8,
 DATE('1970-01-01') AS dm__operand9,
 DATE('1970-01-01') AS dm__operand10,
 DATE('1970-01-01') AS dm__operand11,
 '' AS dm__operand12,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand13,
 DATE('1970-01-01') AS dm__operand14,
 DATE('1970-01-01') AS dm__operand15,
 CAST('FALSE' AS BOOL) AS dm__operand16,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand17,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand18,
 CAST('FALSE' AS BOOL) AS dm__operand19,
 '' AS dm__operand20,
 '' AS dm__operand21,
 '' AS dm__operand22,
 '-1' AS dm__operand23;