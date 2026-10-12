CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_SEC_SECURITY_ROLE as
   /*	
   #DescStart#	
   #$Revision: 7786 $, $LastChangedBy: pbarczak $	
   #SubjectAreas#:	
   #DescEnd#	
   */	
   SELECT	
   security_role_id,	
   security_role_desc,	
   nav_rel_fg	
   FROM p_lew_mart_msi.t_msi_ref_sec_security_role	
;