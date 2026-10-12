CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SEC_ROLE_OBJ_ACL_TMPL_2(	
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
   FROM p_lew_mart_msi.t_sec_role_obj_acl_tmpl_2;