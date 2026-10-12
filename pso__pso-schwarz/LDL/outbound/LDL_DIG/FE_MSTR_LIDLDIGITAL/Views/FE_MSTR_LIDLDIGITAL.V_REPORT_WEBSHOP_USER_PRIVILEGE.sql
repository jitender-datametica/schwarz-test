CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_report_webshop_user_privilege AS SELECT report_name,
 IFNULL(NULLIF(username, ''), '-1') AS username,
 full_mstr_login_name,
 LOWER(full_mstr_login_name) AS lower_full_mstr_login_name,
 wshop_cd
FROM ldl_dig_lec_share.v_meta_report_webshop_user_privilege
UNION ALL
SELECT '-1' AS report_name,
 '-1' AS username,
 '-1' AS full_mstr_login_name,
 '-1' AS lower_full_mstr_login_name,
 '-1' AS wshop_cd;