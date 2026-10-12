CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_gender AS SELECT CASE
  WHEN cust_gender_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_gender_cd, '-1')
  END AS cust_gender_cd,
 cust_gender_descr
FROM ldl_dig_lec_share.v_dim_customer_gender
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;