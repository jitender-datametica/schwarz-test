
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ORIG_ITEM_CASE_SIZE_1 

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
   w.client_id, 
   a.src_wh_id AS wh_id,        
   i.orig_item_nr,      
   i.dat_valid_from,    
   i.case_size  
        
   FROM p_lew_core_ac.v_wawi_itm_item_wh_1 AS w   
   INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_1 AS i    
   ON i.item_sid = w.item_sid   
   AND i.client_id = w.client_id        
   INNER JOIN p_lew_core_ac.v_location_1 AS a     
   ON a.client_id = w.client_id 
   AND a.loc_sid = w.wh_loc_sid 
        
   WHERE w.item_status IN (8,9)                                 /* auf Stati einschränken */    
        
   AND EXISTS(                                                  /* auf noch nicht beendet einschränken */       
           SELECT       
1       
           FROM p_lew_core_ac.v_wawi_itm_item_skey_1 k    
   WHERE k.item_sid = w.item_sid        
   AND k.client_id = w.client_id        
   AND k.dat_rec_end = '9999-12-31'     
 )      
        
AND CURRENT_DATE BETWEEN w.dat_rec_start AND w.dat_rec_end;
