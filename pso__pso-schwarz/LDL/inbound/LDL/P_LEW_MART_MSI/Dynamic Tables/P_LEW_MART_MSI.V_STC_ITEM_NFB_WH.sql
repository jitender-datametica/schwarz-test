
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STC_ITEM_NFB_WH 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9152 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Bestand 
   #DescEnd#   
   */ 
   SELECT   
   sinw.client_id,   
   wh.src_wh_id AS wh_id,  
   sinw.item_sid AS item_id,  
   sinw.dat_formdate,   
   sinw.pos_nr,   
   sinw.pos_nr_link, 
   sinw.nfb_type_cd, 
   sinw.qty_case_nfb,   
   sinw.price_retail / rate_currency_exchange AS price_retail, 
   sinw.price_retail_net / rate_currency_exchange AS price_retail_net,  
   cry.currency_iso_cd, 
   MAX(sinw.dat_dayend)  AS dat_dayend 
    FROM p_lew_core_ac.v_wawi_stc_item_nfb_wh AS sinw 
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh 
   ON wh.client_id = sinw.client_id 
   AND wh.loc_sid_wh =  sinw.wh_loc_sid   
   AND  wh.dwh_actual_fg = 1  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry   
   ON sinw.client_id = cry.client_id   
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
   
   GROUP BY sinw.client_id 
   , wh.src_wh_id 
   , sinw.item_sid   
   , sinw.dat_formdate  
   , sinw.pos_nr  
   , sinw.pos_nr_link   
   , sinw.nfb_type_cd   
   , sinw.qty_case_nfb  
   , sinw.price_retail / rate_currency_exchange
   , sinw.price_retail_net / rate_currency_exchange
   ,cry.currency_iso_cd 
;
