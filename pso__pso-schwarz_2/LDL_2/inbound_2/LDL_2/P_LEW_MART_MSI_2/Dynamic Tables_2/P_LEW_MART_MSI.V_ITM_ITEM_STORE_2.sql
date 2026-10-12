
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_STORE_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 6244 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: Artikelstamm  
   #DescEnd#   
   */ 
   
   SELECT   
   COALESCE (itm.case_size_dec, itm.case_size) AS case_size,   
   org.client_id, 
   itm.dat_valid_from,  
   itmw.item_sid AS item_id,  
   itm.orig_item_nr, 
   itmw.item_status  AS status_id,  
   org.st_loc_sid AS store_id,   
   wh.src_wh_id AS wh_id   
   FROM p_lew_core_ac.v_wawi_itm_item_wh_2 itmw   
   INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_2 itm   
   ON itmw.client_id = itm.client_id   
   AND itm.item_sid = itmw.item_sid 
   INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_act_2  org  
   ON itmw.client_id=org.client_id  
   AND itmw.wh_loc_sid = org.wh_loc_sid   
   INNER JOIN p_lew_bil_ac.v_warehouse_2 wh 
   ON org.client_id=wh.client_id 
   AND org.wh_loc_sid = wh.loc_sid_wh  
   WHERE CURRENT_DATE BETWEEN itmw.dat_rec_start AND itmw.dat_rec_end   
   
   GROUP BY 1,2,3,4,5,6,7,8;
