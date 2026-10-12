CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CT_SEC_ROLE_OBJ_ACL_PERMS_2
(
     security_role_id
   , security_role_desc
   , permission_type
   , actual_entry_auth
   , change_entry_auth
   , entry_user
   , zero_val
)
AS
   SELECT
        security_role_id,
   security_role_desc,
   permission_type,
   actual_entry_auth,
   change_entry_auth,
   entry_user,
   zero_val
  FROM p_lew_mart_msi.v_ct_sec_role_obj_acl_perms_2
;