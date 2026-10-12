CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_blocked_reason_2 AS SELECT CASE
  WHEN cust_blocked_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_blocked_reason_cd, '-1')
  END AS cust_blocked_reason_cd,
 cust_blocked_reason_descr
FROM ldl_dig_lec_share.v_dim_customer_blocked_reason_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;