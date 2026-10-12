
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_INTERFACE_WH_2
 /*
 #DescStart#    
 #$Revision: 9149 $, $LastChangedBy: aarnold $  
 #SubjectAreas#: Kleinbelege / Storeforms   
 #DescEnd#  
 */ 
(   
    client_id   
    , wh_id 
    , system_key    
    , system_desc   
    , interface_key 
    , interface_desc    
    , dat_rec_start 
    , dat_rec_end   
    , load_id   
) 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS  
   SELECT   
       whin.client_id,  
   wh.src_wh_id AS wh_id,   
   whin.system_key, 
   whin.system_desc,    
   whin.interface_key,  
   whin.interface_desc, 
   whin.dat_rec_start,  
   whin.dat_rec_end,    
   whin.load_id 
  FROM p_lew_core_ac.v_wawi_ref_wh_interface_2 AS whin    
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh    
   ON wh.client_id = whin.client_id 
   AND wh.loc_sid_wh =  whin.wh_loc_sid 
   AND wh.dwh_actual_fg = 1 
;
