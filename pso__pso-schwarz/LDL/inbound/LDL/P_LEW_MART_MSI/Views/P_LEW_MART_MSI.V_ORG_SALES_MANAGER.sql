CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_SALES_MANAGER(	
   client_id	
  ,wh_id	
  ,store_id	
  ,sales_manager_id	
  ,sales_manager_name	
  ,account_manager_id	
)	
AS	
   SELECT	
      client_id,	
   wh_id,	
   store_id,	
   sales_manager_id,	
   sales_manager_name,	
   account_manager_id	
   FROM p_lew_mart_msi.t_org_sales_manager;