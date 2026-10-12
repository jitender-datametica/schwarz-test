
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STORE_DAY_BER_PYM_PPY_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*   
   #DescStart#  
   #$Revision: 8128 $, $LastChangedBy: hwieber $  
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)  
   #DescEnd#  
   */ 
  
   SELECT 
      agg.client_id                                    AS client_id,  
   cry.currency_iso_cd                              AS currency_iso_cd, 
   agg.loc_sid                                      AS store_id,  
   a12.dat_calendar_amd                             AS dat_formdate,  
   agg.sales_gross_val / cry.rate_currency_exchange AS val_retail_asis_ber, 
   agg.sales_net_val / cry.rate_currency_exchange   AS val_retail_net_asis_ber, 
   cnt_customer                                     AS cnt_customer_asis_ber  
   FROM p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_2 agg 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 cry 
   ON agg.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
  
   JOIN p_lew_mart_msi.v_cal_month_ber_2 a12  
   ON agg.dwh_cal_dt = a12.dat_calendar_pyd 
  
   JOIN p_lew_mart_msi.v_org_all_store_reloc_2 a13  
   ON agg.client_id = a13.client_id 
   AND agg.loc_sid = a13.store_id 
  
   JOIN p_lew_core_ac.v_wawi_org_store_act_2 store  
   ON a13.client_id = store.client_id 
   AND a13.store_id = store.st_loc_sid  
   AND test_store_fg = 0  
   AND CURRENT_DATE >= dat_opening  
  
 WHERE  
   (  
     (a12.dat_calendar_amd BETWEEN store.dat_calc_start_ppy AND Add_Months(store.dat_calc_end_py,12)) 
     OR (a12.dat_calendar_amd>=store.dat_calc_start_ppy AND a13.move_fg=1)  
     OR (a12.dat_calendar_amd>=store.dat_calc_start_ppy AND store.dat_calc_end_py IS NULL)  
   )  
;
