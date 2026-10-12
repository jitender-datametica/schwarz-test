/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_STORAGE_REAL_STOCK_NF_ASIS_2 
#----------------------------------------------------------------------------
# History:
#  1.0  06.07.2023    Ulrich Ross        User Story 490502, Init
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_STORE_STORAGE_REAL_STOCK_NF_ASIS_2 (
   client_id
  ,country_lidl_cd
  ,orig_store_nr
  ,loc_sid
  ,wh_id
  ,orig_item_nr
  ,item_sid
  ,retailspace_qty
  ,stock_real_qty
  ,valid_from_stockreal
  ,valid_to_stockreal
  ,store_storage_qty
  ,valid_from_storestorage
  ,valid_to_storestorage
  ,update_date                    
  ,insert_date 
) AS

SELECT
   client_id                      
  ,country_lidl_cd                
  ,orig_store_nr                  
  ,loc_sid                        
  ,wh_id                          
  ,orig_item_nr                   
  ,item_sid    
  ,stock_real_qty - store_storage_qty AS retailspace_qty
  ,stock_real_qty                 
  ,valid_from_stockreal   
  ,valid_to_stockreal      
  ,store_storage_qty              
  ,valid_from_storestorage
  ,valid_to_storestorage 
  ,update_date                    
  ,insert_date                    
  
FROM P_LEW_MART_WFM.T_STORE_STORAGE_REAL_STOCK_NF_ASIS_2
;
