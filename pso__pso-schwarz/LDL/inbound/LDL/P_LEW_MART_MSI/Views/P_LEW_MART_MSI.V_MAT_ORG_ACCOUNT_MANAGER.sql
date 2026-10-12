CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ORG_ACCOUNT_MANAGER as
   SELECT s2wlk.client_id,	
   s2wlk.src_wh_id AS wh_id,	
   Coalesce(org.account_manager_id , -1) AS account_manager_id,	
   Max(Coalesce(org.account_manager_name, 'Vertriebsleiter'))  AS account_manager_name	
  FROM p_lew_bil_ac.v_store_to_warehouse_lastknown AS s2wlk	
   LEFT OUTER JOIN p_lew_bil_ac.v_location_organization AS org	
   ON  s2wlk.client_id = org.client_id	
   AND s2wlk.loc_sid_wh = org.loc_sid_wh	
   AND s2wlk.loc_sid_store = org.loc_sid_store	
GROUP BY s2wlk.client_id	
, s2wlk.src_wh_id	
, Coalesce(org.account_manager_id , -1)	
;