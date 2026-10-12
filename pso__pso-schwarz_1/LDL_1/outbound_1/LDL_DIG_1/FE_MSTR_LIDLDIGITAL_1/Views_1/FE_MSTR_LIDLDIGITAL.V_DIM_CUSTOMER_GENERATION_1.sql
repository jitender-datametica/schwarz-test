CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_generation_1 (cust_generation_cd, cust_generation_descr
, generation_start_cy, generation_end_cy) AS SELECT cust_generation_cd,
 cust_generation_descr,
 generation_start_cy,
 generation_end_cy
FROM ldl_dig_lec_share.v_dim_customer_generation_1
UNION DISTINCT
SELECT '-1',
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0);