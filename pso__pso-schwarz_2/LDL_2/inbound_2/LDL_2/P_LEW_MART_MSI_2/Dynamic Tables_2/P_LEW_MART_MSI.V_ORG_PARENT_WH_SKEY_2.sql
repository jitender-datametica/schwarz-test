
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_PARENT_WH_SKEY_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
       SELECT DISTINCT      
             wh_skey.client_id,    
       wh2.src_wh_id  AS parent_wh_id,    
       wh.src_wh_id AS wh_id,      
       aspect_id     
       
FROM p_lew_core_ac.v_wawi_org_parent_wh_skey_2 wh_skey    
       INNER JOIN p_lew_bil_ac.v_warehouse_2 wh    
       ON wh_skey.wh_loc_sid = wh.loc_sid_wh     
       AND wh_skey.client_id = wh.client_id      
       AND wh.dwh_actual_fg = 1    
       INNER JOIN p_lew_bil_ac.v_warehouse_2 wh2   
       ON wh_skey.parent_wh_loc_sid = wh2.loc_sid_wh    
       AND wh_skey.client_id = wh2.client_id     
       AND wh2.dwh_actual_fg = 1   
       
       UNION ALL     
       /* dummy_2 warehouse for country_2 level in aspect id 1 and 2 */   
       SELECT 
             client_id                                         AS client_id, 
       -1*client_id                                      AS parent_wh_id,    
       -1*client_id                                      AS wh_id,    
       multiply.row_no                                   AS aspect_id 
       
FROM p_lew_core_ac.v_wawi_ref_client_country_2 AS clnt    
       INNER JOIN p_lew_core_ac.v_wawi_ref_country_2  AS cntr    
       ON clnt.country_id = cntr.country_id      
       CROSS JOIN (  
       SELECT 1 AS row_no   
       FROM (SELECT 1 AS one) SUB1 
           UNION ALL 
       SELECT 2 AS row_no   
       FROM (SELECT 1 AS two) SUB2 
       ) AS multiply 
WHERE cntr.dashboard_relevant_fg = 1;
