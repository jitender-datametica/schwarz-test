CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_touchpoint_level2_1 (cust_touchpoint_lvl2_id,
cust_touchpoint_lvl1_id, cust_touchpoint_lvl2_name) AS SELECT cust_touchpoint_lvl2_id,
 IFNULL(cust_touchpoint_lvl1_id, -1) AS cust_touchpoint_lvl1_id,
 cust_touchpoint_lvl2_name
FROM ldl_dig_lec_share.v_dim_customer_touchpoint_level2_1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '';