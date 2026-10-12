
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_VAT_EJR_AVG_ORG 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT   
      vat.client_id, 
   cry.currency_iso_cd, 
   vat.st_loc_sid                                                 AS store_id,   
   vat.orig_store_nr,   
   vat.dat_formdate, 
   l.src_wh_id                                                    AS wh_id,   
   vat.cy_month,  
   vat.val_rtl_gross_ejr/cry.rate_currency_exchange               AS val_rtl_gross_ejr,   
   vat.val_rtl_net_ejr/cry.rate_currency_exchange                 AS val_rtl_net_ejr,  
   vat.avg_pct_vat_store,  
   vat.avg_pct_vat_store_previous_day, 
   vat.avg_pct_vat_wh,  
   (txj.sales_gross_val_wawi * (-1)) / cry.rate_currency_exchange AS val_retail_wawi_asis,   
   (txj.sales_net_val_wawi * (-1)) / cry.rate_currency_exchange   AS val_retail_net_wawi_asis   
   FROM p_lew_core_ac.v_wawi_agg_store_avg_vat_values_ejr AS vat  
   INNER JOIN p_lew_core_ac.v_location l  
   ON vat.client_id = l.client_id   
   AND vat.wh_loc_sid = l.loc_sid   
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry   
   ON vat.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
   LEFT OUTER JOIN p_lew_bil_ac.v_agg_pos_txj_wawi_store_day AS txj  
   ON vat.client_id = txj.client_id 
   AND vat.st_loc_sid = txj.loc_sid 
   AND vat.dat_formdate  = txj.dwh_cal_dt 
;
