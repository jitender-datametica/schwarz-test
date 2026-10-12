CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_cost_center_user_privilege_1 AS SELECT IFNULL(NULLIF(username, ''
   ), '-1') AS username,
 full_mstr_login_name,
 LOWER(full_mstr_login_name) AS lower_full_mstr_login_name,
 fiscal_year,
 cost_center_nr
FROM ldl_dig_lec_share.v_meta_rel_cost_center_user_privilege_1
UNION ALL
SELECT '-1' AS username,
 '-1' AS full_mstr_login_name,
 '-1' AS lower_full_mstr_login_name,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS fiscal_year,
 '-1' AS cost_center_nr;