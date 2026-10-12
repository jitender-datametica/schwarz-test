CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sec_role_obj_acl_tmpl_2 (change_type, attribute_frst, attribute_scnd,
change_type_value, change_dat, load_id, entry_user, approval_user) AS SELECT change_type,
 attribute_frst,
 attribute_scnd,
 change_type_value,
 change_dat,
 load_id,
 entry_user,
 approval_user
FROM ldl_p_lew_mart_msi.t_sec_role_obj_acl_tmpl_2;