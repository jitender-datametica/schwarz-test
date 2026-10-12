CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SEC_ROLE_ACL_TMPL_2(	
 change_type	
 ,security_role_desc	
 ,dashboard_name	
 ,authorized	
 ,change_dat	
 ,load_id	
 ,approval_user	
 ,entry_user	
)	
AS	
   SELECT	
         change_type,	
   security_role_desc,	
   dashboard_name,	
   authorized,	
   change_dat,	
   load_id,	
   approval_user,	
   entry_user	
   FROM p_lew_mart_msi.t_sec_role_acl_tmpl_2	
;