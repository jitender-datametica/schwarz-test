CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_stock_age_cluster_1 AS SELECT prod_stock_age_cluster_cd,
 prod_stock_age_cluster_descr,
 cluster_first_day,
 cluster_last_day
FROM ldl_dig_lec_share.v_dim_product_stock_age_cluster_1
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand2,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand3;