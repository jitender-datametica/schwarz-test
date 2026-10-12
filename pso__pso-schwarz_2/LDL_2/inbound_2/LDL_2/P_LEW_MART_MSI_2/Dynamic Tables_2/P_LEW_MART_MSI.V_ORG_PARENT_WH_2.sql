
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_PARENT_WH_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
    /*  
    #DescStart# 
    #$Revision: 6244 $, $LastChangedBy: hwieber $ 
    #SubjectAreas#: Organisationsstruktur 
    #DescEnd# 
    */  
  
    SELECT  
      pwh.client_id,  
    wh.src_wh_id  AS parent_wh_id,  
    parent_wh_desc, 
    parent_wh_fg  
  
FROM p_lew_core_ac.v_wawi_org_parent_wh_2 pwh 
    INNER JOIN p_lew_bil_ac.v_warehouse_2 wh  
    ON pwh.parent_wh_loc_sid = wh.loc_sid_wh  
    AND pwh.client_id = wh.client_id  
    AND wh.dwh_actual_fg = 1  
  
    UNION ALL 
    /* dummy_2 warehouse for country_2 level in aspect id 1 and 2 */  
    SELECT  
      client_id,  
    -1 * client_id                                                     AS parent_wh_id, 
    CAST('#'|| TRIM( cntr.country_iso_cd) AS VARCHAR(50))     AS parent_wh_desc,  
    0                                                                  AS parent_wh_fg  
  
FROM p_lew_core_ac.v_wawi_ref_client_country_2 AS clnt  
    INNER JOIN p_lew_core_ac.v_wawi_ref_country_2  AS cntr  
    ON clnt.country_id = cntr.country_id  
  
    WHERE cntr.dashboard_relevant_fg = 1;
