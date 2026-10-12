
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STORE_DAY_BER_PYW_PPY

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
      a.client_id                                    AS client_id,  
   a.loc_sid                                      AS store_id,  
   cry.currency_iso_cd                            AS currency_iso_cd, 
   b.dat_calendar                                 AS dat_formdate,  
   a.sales_gross_val / cry.rate_currency_exchange AS val_retail_asis_ber, 
   a.sales_net_val / cry.rate_currency_exchange   AS val_retail_net_asis_ber, 
   a.cnt_customer                                 AS cnt_customer_asis_ber  
   FROM p_lew_bil_ac.v_agg_pos_txj_wawi_store_day a 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate cry 
   ON a.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
   INNER JOIN p_lew_mart_msi.v_cal_calendarday AS b 
   ON a.dwh_cal_dt = b.prev_cy_dat_calendar_samewday  
   INNER JOIN p_lew_core_ac.v_wawi_org_all_store_reloc_act AS rel 
   ON a.client_id = rel.client_id 
   AND a.loc_sid = rel.st_loc_sid 
   INNER JOIN p_lew_core_ac.v_wawi_org_store_act AS osa 
   ON a.client_id = osa.client_id 
   AND a.loc_sid = osa.st_loc_sid 
   AND osa.test_store_fg = 0  
   AND CURRENT_DATE >= osa.dat_opening  
  
 WHERE  
 (  
   (b.dat_calendar >=  osa.dat_calc_start_ppy AND rel.move_fg = 1)  
   OR (b.dat_calendar BETWEEN osa.dat_calc_start_ppy AND ADD_MONTHS(osa.dat_calc_end_py, 12)) 
   OR (b.dat_calendar >=  osa.dat_calc_start_ppy AND osa.dat_calc_end_py IS NULL) 
 )  
;
