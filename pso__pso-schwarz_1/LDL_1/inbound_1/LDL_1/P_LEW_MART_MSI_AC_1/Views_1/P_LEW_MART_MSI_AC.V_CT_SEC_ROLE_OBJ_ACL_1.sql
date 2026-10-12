CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CT_SEC_ROLE_OBJ_ACL_1
(
     p_lft_id
   , p_rgt_id
   , p_object_name
   , nstd_lft_id
   , nstd_rgt_id
   , object_name
   , object_type_id
   , object_path
   , security_role_id
   , security_role_desc
   , actual_entry_auth
   , change_entry_auth
   , entry_user
   , zero_val
)
AS
   SELECT
        p_lft_id,
   p_rgt_id,
   p_object_name,
   nstd_lft_id,
   nstd_rgt_id,
   object_name,
   object_type_id,
   object_path,
   security_role_id,
   security_role_desc,
   actual_entry_auth,
   change_entry_auth,
   entry_user,
   zero_val
     FROM p_lew_mart_msi.v_ct_sec_role_obj_acl_1
;