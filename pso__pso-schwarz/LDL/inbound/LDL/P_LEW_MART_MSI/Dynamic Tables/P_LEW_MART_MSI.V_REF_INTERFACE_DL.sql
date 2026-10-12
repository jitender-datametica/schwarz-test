
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_INTERFACE_DL 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*   
   #DescStart#  
   #$Revision: 9148 $, $LastChangedBy: aarnold $    
   #SubjectAreas#: Kleinbelege / Storeforms 
   #DescEnd#    
   */   
   SELECT   
       a.client_id, 
   wh.src_wh_id AS wh_id     /* Gesellschaft */,    
   a.dat_rec_end,   
   a.dat_rec_start, 
   a.interface_desc,    
   a.interface_key, 
   a.load_id,   
   a.system_desc,   
   a.system_key 
  FROM p_lew_core_ac.v_wawi_ref_wh_interface AS a   
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh    
   ON wh.client_id = a.client_id    
   AND wh.loc_sid_wh = a.wh_loc_sid 
   AND wh.dwh_actual_fg = 1 
WHERE wh.src_wh_id = 0  
;
