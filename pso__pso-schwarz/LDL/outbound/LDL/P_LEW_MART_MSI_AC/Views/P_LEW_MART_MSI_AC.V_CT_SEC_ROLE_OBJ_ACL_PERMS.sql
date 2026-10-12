CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ct_sec_role_obj_acl_perms (security_role_id, security_role_desc,
permission_type, actual_entry_auth, change_entry_auth, entry_user, zero_val) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ct_sec_role_obj_acl_perms;