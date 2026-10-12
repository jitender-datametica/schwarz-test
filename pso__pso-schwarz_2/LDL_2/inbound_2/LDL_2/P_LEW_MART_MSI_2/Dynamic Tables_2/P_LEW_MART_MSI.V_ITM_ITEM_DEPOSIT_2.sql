
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_DEPOSIT_2 

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
   itm.client_id, 
   itm.item_sid AS item_id,   
   itm.val_deposit / cry.rate_currency_exchange        AS val_deposit,  
   cry.currency_iso_cd  
   
    FROM p_lew_core_ac.v_wawi_itm_item_act_2 AS itm  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry   
   ON itm.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end;
