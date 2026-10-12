CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_ACCOUNT_MANAGER_2	
/*
#DescStart#	
#$Revision: 6930 $, $LastChangedBy: mueding $	
#SubjectAreas#: Organisationsstruktur	
#DescEnd#	
*/	
(	
   client_id	
  ,wh_id	
  ,account_manager_id	
  ,account_manager_name	
)	
AS	
   SELECT	
      client_id,	
   wh_id,	
   account_manager_id,	
   account_manager_name	
   FROM p_lew_mart_msi.t_org_account_manager_2;