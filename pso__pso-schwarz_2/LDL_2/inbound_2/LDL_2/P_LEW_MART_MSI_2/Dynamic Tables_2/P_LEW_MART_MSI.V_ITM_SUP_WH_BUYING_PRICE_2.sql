
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_SUP_WH_BUYING_PRICE_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS  
   /*   
   #DescStart#  
   #$Revision: 8862 $, $LastChangedBy: hwieber $    
   #SubjectAreas#: Artikelstamm 
   #DescEnd#    
   */   
    
   SELECT   
       sup.client_id,   
   vlmk.src_wh_id AS wh_id, 
   sup.item_sid AS item_id, 
   sup.sup_sid AS supplier_id,  
   sup.dat_rec_start,   
   sup.dat_rec_end, 
   sup.dat_valid_from,  
   sup.dat_valid_until, 
   sup.dat_valid_until_group,   
   sup.curr_sid                  AS currency_nr,    
   sup.currency_nr_special, 
   sup.group_nr,    
   sup.delivery_item_cd,    
   sup.dur_shelflife_cust,  
   sup.period_id_shelflife_cust,    
   sup.dur_shelflife_store, 
   sup.period_id_shelflife_store,   
   sup.dur_shelflife_wh,    
   sup.period_id_shelflife_wh,  
   sup.price_buying,    
   sup.price_buying_special 
    
    FROM  p_lew_bil_ac.v_itm_sup_wh_buying_price_2 sup    
   INNER JOIN  p_lew_core_ac.v_location_2 AS vlmk 
   ON vlmk.loc_sid = sup.wh_loc_sid 
    
   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end 
;
