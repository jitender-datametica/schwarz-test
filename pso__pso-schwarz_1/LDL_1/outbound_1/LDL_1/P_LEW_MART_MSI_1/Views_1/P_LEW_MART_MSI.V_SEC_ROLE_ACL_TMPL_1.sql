CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sec_role_acl_tmpl_1 (change_type, security_role_desc, dashboard_name,
authorized, change_dat, load_id, approval_user, entry_user) AS SELECT change_type,
 security_role_desc,
 dashboard_name,
 authorized,
 change_dat,
 load_id,
 approval_user,
 entry_user
FROM ldl_p_lew_mart_msi.t_sec_role_acl_tmpl_1;