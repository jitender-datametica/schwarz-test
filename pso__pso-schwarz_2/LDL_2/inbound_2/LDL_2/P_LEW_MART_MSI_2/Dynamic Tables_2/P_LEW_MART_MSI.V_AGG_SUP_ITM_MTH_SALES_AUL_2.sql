
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_SUP_ITM_MTH_SALES_AUL_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS  
   /* 
   #DescStart#  
   #$Revision: 8320 $, $LastChangedBy: mueding $  
   #SubjectAreas#: Unbekannt  
   #DescEnd#  
   */ 
   SELECT 
      cl.client_id, 
   c.country_iso_cd,  
   mth.cy_month,  
   itmp.item_sid_map AS item_id,  
   iis.orig_item_nr,  
   sls.dat_valid_from_item, 
   iis.case_size, 
   sls.qty_total, 
   sls.val_rtl_ejr_asis,  
   sls.val_rtl_net_ejr_asis,  
   sls.val_rtl_str_days_w_sales_asis, 
   sls.val_rtl_str_net_days_w_s_asis, 
   sls.avg_qty_sold_per_str_week, 
   iw.wh_id,  
   agg.supplier_id, 
   agg.orig_supplier_nr,  
   sls.currency_iso_cd, 
   agg.qty_total_rcv  
   FROM p_lew_mart_msi.v_ref_country_2 AS c 
   INNER JOIN p_lew_mart_msi.v_ref_client_2 AS cl 
   ON c.country_id = cl.country_id  
   INNER JOIN p_lew_mart_msi.v_cal_month_2 AS mth 
   ON mth.cy_month IS NOT NULL  
   INNER JOIN p_lew_mart_msi.v_itm_item_skey_2 AS iis 
   ON cl.client_id = iis.client_id  
   INNER JOIN p_lew_mart_msi.v_itm_item_wh_2 AS iw  
   ON cl.client_id = iw.client_id 
   AND iis.item_id  =  iw.item_id 
   LEFT OUTER JOIN  
   (  
     SELECT 
        irw.client_id,  
   irw.wh_id, 
   irw.item_id, 
   irw.supplier_id, 
   sup.orig_supplier_nr,  
   cal.cy_month,  
   irw.currency_iso_cd, 
   SUM(irw.qty_total_rcv) AS qty_total_rcv  
     FROM p_lew_mart_msi.v_cal_calendarday_2 AS cal 
   INNER JOIN p_lew_mart_msi.v_mov_item_receive_wh_2 AS irw 
   ON irw.receipt_pos_nr_rcv BETWEEN 0 AND 499  
   AND cal.dat_calendar = irw.dat_entry_rcv 
   AND irw.currency_iso_cd = 'EUR'  
   INNER JOIN p_lew_mart_msi.v_sup_supplier_skey_2 AS sup 
   ON irw.client_id = sup.client_id 
   AND irw.supplier_id  =  sup.supplier_id  
  
   GROUP BY 
      irw.client_id 
     ,irw.wh_id 
     ,irw.item_id 
     ,irw.supplier_id 
     ,sup.orig_supplier_nr  
     ,cal.cy_month  
     ,irw.currency_iso_cd 
 ) AS agg 
   ON cl.client_id = agg.client_id  
   AND iw.wh_id  =  agg.wh_id 
   AND iw.item_id  =  agg.item_id 
   AND mth.cy_month = agg.cy_month  
   LEFT OUTER JOIN p_lew_mart_msi.v_agg_wh_itm_mth_sales_asis_2 AS sls  
   ON cl.client_id = sls.client_id  
   AND iw.wh_id  =  sls.wh_id 
   AND mth.cy_month = sls.cy_month  
   AND iis.orig_item_nr = sls.orig_item_nr  
   INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp 
   ON itmp.client_id = iis.client_id  
   AND itmp.item_sid = iis.item_id  
  
 WHERE agg.orig_supplier_nr IS NOT NULL 
;
