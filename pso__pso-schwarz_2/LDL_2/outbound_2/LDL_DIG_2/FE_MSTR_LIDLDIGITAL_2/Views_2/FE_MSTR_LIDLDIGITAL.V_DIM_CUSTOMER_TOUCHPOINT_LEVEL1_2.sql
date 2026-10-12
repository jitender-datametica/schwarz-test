CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_touchpoint_level1_2 (cust_touchpoint_lvl1_id,
cust_touchpoint_lvl1_name) AS SELECT cust_touchpoint_lvl1_id,
 cust_touchpoint_lvl1_name
FROM ldl_dig_lec_share.v_dim_customer_touchpoint_level1_2
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '';