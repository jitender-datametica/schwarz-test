
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_STORE_SALES_SKEY_ACT_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart#  
   #$Revision: 9130 $, $LastChangedBy: aarnold $  
   #SubjectAreas#: Organisationsstruktur  
   #DescEnd#  
   */ 
   SELECT 
    w.client_id,  
   w.st_loc_sid               AS store_id,  
   wh.src_wh_id              AS sales_wh_id,  
   s.orig_store_nr  
   FROM p_lew_core_ac.v_wawi_org_wh_store_2 AS w  
   INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_act_2 AS s  
   ON s.client_id = w.client_id 
   AND s.st_loc_sid = w.st_loc_sid  
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh  
   ON w.client_id = wh.client_id  
   AND w.wh_loc_sid = wh.loc_sid_wh 
   AND wh.dwh_actual_fg = 1 
  
   WHERE w.wh_type_id = 1 
     AND CURRENT_DATE BETWEEN w.dat_rec_start AND w.dat_rec_end 
   -- The following line may be subject to change regarding OP#198066, patch 833  
     AND wh.src_wh_id <> s.orig_store_nr  
   -- The following line ensures that the primary key is not violated.  
   QUALIFY ROW_NUMBER() OVER (PARTITION BY w.client_id, w.st_loc_sid ORDER BY w.dat_rec_end DESC NULLS LAST, w.dat_rec_start DESC NULLS LAST, w.wh_loc_sid DESC NULLS LAST) = 1 
; 
