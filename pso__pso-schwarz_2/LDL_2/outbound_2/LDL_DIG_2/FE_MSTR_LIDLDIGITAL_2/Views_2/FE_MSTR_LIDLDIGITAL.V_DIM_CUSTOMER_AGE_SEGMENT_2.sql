CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_age_segment_2 AS SELECT CASE
  WHEN cust_age_segm_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_age_segm_cd, '-1')
  END AS cust_age_segm_cd,
  CASE
  WHEN cust_age_segm_type_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_age_segm_type_cd, '-1')
  END AS cust_age_segm_type_cd,
 cust_age_segm_descr,
 cust_age_segm_start_year,
 cust_age_segm_end_year
FROM ldl_dig_lec_share.v_dim_customer_age_segment_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '-1' AS dm__operand1,
 '' AS dm__operand2,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand3,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand4;