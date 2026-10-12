
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_WH_MANAGEMENT_REGION_2 

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
          reg.client_id,  
        wh.src_wh_id AS wh_id,  
        reg.managing_board_int, 
        reg.managing_director_sales,  
        reg.managing_director_region, 
        reg.region_id 
    FROM p_lew_core_ac.v_wawi_ref_wh_management_region_2 AS reg 
        INNER JOIN p_lew_bil_ac.v_warehouse_2 wh  
        ON reg.wh_loc_sid = wh.loc_sid_wh 
        AND reg.client_id = wh.client_id  
        AND wh.dwh_actual_fg = 1  
  
        GROUP BY 1,2,3,4,5,6;
