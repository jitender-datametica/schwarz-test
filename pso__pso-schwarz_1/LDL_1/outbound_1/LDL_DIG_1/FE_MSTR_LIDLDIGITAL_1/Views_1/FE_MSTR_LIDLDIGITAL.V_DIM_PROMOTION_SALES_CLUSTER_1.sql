CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_promotion_sales_cluster_1 AS SELECT IFNULL(promo_sale_cluster_cd
  , -1) AS promo_sale_cluster_cd,
 promo_sale_cluster_descr,
 last_week_nr
FROM ldl_dig_lec_share.v_dim_promotion_sales_cluster_1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '-1' AS dm__operand1,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand2;