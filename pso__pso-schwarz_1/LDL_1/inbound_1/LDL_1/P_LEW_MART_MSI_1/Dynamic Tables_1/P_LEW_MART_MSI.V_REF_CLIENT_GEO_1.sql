
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_CLIENT_GEO_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
           SELECT 
             geo.client_id, 
           geo.longitude, 
           geo.latitude 
 FROM p_lew_core_ac.v_wawi_ref_wh_geo_1 AS geo  
           INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh  
           ON geo.client_id = wh.client_id  
           AND geo.wh_loc_sid= wh.loc_sid_wh  
           AND wh.dwh_actual_fg = 1 
WHERE wh.src_wh_id = 0  
;
