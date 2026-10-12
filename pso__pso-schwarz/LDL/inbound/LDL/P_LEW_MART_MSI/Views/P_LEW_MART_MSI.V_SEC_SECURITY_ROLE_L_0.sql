CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SEC_SECURITY_ROLE_L_0 as
   select	
   change_type,	
   security_role_desc,	
   dashboard_name,	
   authorized,	
   change_dat,	
   load_id,	
   approval_user,	
   entry_user	
  from p_lew_core_ac.v_wawi_load_sec_security_role_l_0	
;