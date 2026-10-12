
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_WAWI_INV_ITEM_WH_EJR 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS 
   /* 
   #DescStart# 
   #$Revision: 8128 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: Inventuren/Kassendaten    
   #DescEnd#   
   */ 
   SELECT   
      agg.client_id, 
   agg.wh_id,  
   agg.inv_id, 
   agg.inv_start_date,  
   agg.inv_end_date, 
   agg.item_id,   
   agg.val_rtl_ejr_asis / b.rate_currency_exchange          AS val_rtl_ejr_asis, 
   agg.val_rtl_net_ejr_asis / b.rate_currency_exchange     AS val_rtl_net_ejr_asis, 
   agg.val_return_ejr_asis / b.rate_currency_exchange       AS val_return_ejr_asis, 
   agg.val_return_net_ejr_asis / b.rate_currency_exchange   AS val_return_net_ejr_asis,   
   b.currency_iso_cd AS currency_iso_cd   
   FROM  
   (  
     SELECT 
        inv.client_id,  
   wh.wh_id                     AS wh_id, 
   inv.inv_id                   AS inv_id,   
   inv.prev_dat_formdate+1      AS inv_start_date, 
   inv.dat_formdate             AS inv_end_date,   
   net.item_sid                 AS item_id,  
   SUM(net.sales_gross_val)     AS val_rtl_ejr_asis,  
   SUM(net.sales_net_val)       AS val_rtl_net_ejr_asis, 
   SUM(net.return_gross_val)    AS val_return_ejr_asis,  
   SUM(net.return_net_val)      AS val_return_net_ejr_asis  
     FROM p_lew_core_ac.v_wawi_inv_item_wh_prev_dat AS inv  
   INNER JOIN p_lew_core_ac.v_location l  
   ON inv.client_id = l.client_id   
   AND inv.wh_loc_sid = l.loc_sid   
   INNER JOIN p_lew_mart_msi.v_org_wh wh  
   ON l.client_id = wh.client_id 
   AND l.src_wh_id = wh.wh_id 
   INNER JOIN p_lew_bil_ac.v_agg_pos_wh_day_item_asis AS net   
   ON net.client_id = inv.client_id 
   AND net.loc_sid_wh = inv.wh_loc_sid 
   AND net.dwh_cal_dt BETWEEN inv.prev_dat_formdate+1 AND inv.dat_formdate 
   
 GROUP BY 1,2,3,4,5,6   
) AS agg 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS b  
   ON b.client_id = agg.client_id   
   AND CURRENT_DATE BETWEEN b.dat_rec_start AND b.dat_rec_end  
;
