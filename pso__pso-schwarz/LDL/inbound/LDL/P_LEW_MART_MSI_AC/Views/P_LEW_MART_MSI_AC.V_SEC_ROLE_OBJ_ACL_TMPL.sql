CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SEC_ROLE_OBJ_ACL_TMPL
(
 change_type
 ,attribute_frst
 ,attribute_scnd
 ,change_type_value
 ,change_dat
 ,load_id
 ,entry_user
 ,approval_user
)
AS
   SELECT
         change_type,
   attribute_frst,
   attribute_scnd,
   change_type_value,
   change_dat,
   load_id,
   entry_user,
   approval_user
   FROM p_lew_mart_msi.v_sec_role_obj_acl_tmpl
;