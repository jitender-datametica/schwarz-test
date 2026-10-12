CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_touchpoint_level3 (cust_touchpoint_lvl3_id,
cust_touchpoint_lvl2_id, cust_touchpoint_lvl3_name) AS SELECT cust_touchpoint_lvl3_id,
 IFNULL(cust_touchpoint_lvl2_id, -1) AS cust_touchpoint_lvl2_id,
 cust_touchpoint_lvl3_name
FROM ldl_dig_lec_share.v_dim_customer_touchpoint_level3
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '';