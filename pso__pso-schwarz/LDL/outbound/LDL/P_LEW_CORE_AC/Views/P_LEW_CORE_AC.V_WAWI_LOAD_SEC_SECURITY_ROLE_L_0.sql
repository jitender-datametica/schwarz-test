CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_load_sec_security_role_l_0 (change_type, security_role_desc,
dashboard_name, authorized, change_dat, load_id, approval_user, entry_user) AS SELECT change_type,
 security_role_desc,
 dashboard_name,
 authorized,
 change_dat,
 load_id,
 approval_user,
 entry_user
FROM ldl_p_lew_core.t_wawi_load_sec_security_role_l_0;