
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_STORE_OPENDOCS_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9100 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Inventur_2   
   #DescEnd#   
   */ 
   
   SELECT   
   isod.client_id,   
   isod.st_loc_sid AS store_id,  
   wh.src_wh_id AS wh_id,  
   isod.inv_id,   
   isod.sfotype_id,  
   isod.dat_dayend,  
   isod.dat_formdate,   
   isod.orig_receipt_nr_opendocs,   
   isod.val_debit_opendocs  / rate_currency_exchange AS val_debit_opendocs,   
   isod.val_debit_opendocs_net  / rate_currency_exchange AS val_debit_opendocs_net, 
   isod.val_credit_opendocs / rate_currency_exchange AS val_credit_opendocs,  
   isod.val_credit_opendocs_net / rate_currency_exchange AS val_credit_opendocs_net,   
   cry.currency_iso_cd, 
   cry.rate_currency_exchange 
   FROM p_lew_core_ac.v_wawi_inv_store_opendocs_2 AS isod  
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh 
   ON wh.client_id = isod.client_id 
   AND wh.loc_sid_wh =  isod.wh_loc_sid   
   AND wh.dwh_actual_fg = 1   
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry   
   ON  isod.client_id = cry.client_id  
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
   INNER JOIN p_lew_core_ac.v_wawi_inv_store_2 AS h  
   ON  isod.client_id  = h.client_id   
   AND isod.st_loc_sid    =  h.st_loc_sid 
   AND isod.wh_loc_sid       =  h.wh_loc_sid 
   AND isod.inv_id     = h.inv_id   
   AND isod.dat_dayend = h.dat_dayend  
   AND h.inv_fg   = 71  
   AND h.status_inv_sic = 64  
;
