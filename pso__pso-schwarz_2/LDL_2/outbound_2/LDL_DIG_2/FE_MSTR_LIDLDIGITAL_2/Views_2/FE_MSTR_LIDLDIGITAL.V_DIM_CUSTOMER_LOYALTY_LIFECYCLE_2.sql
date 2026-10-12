CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_loyalty_lifecycle_2 (cust_loyalty_lifecycle_cd,
cust_loyalty_lifecycle_descr) AS SELECT CASE
  WHEN cust_loyalty_lifecycle_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_loyalty_lifecycle_cd, '-1')
  END AS cust_loyalty_lifecycle_cd,
 cust_loyalty_lifecycle_descr
FROM ldl_dig_lec_share.v_dim_customer_loyalty_lifecycle_2
UNION DISTINCT
SELECT '-1',
 '';