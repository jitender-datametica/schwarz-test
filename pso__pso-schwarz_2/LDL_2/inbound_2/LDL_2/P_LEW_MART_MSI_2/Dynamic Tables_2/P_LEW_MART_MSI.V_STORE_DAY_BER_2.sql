
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STORE_DAY_BER_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   DescStart  
   $Revision: 8128 $, $LastChangedBy: hwieber $ 
   SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)  
   DescEnd  
   */ 
   SELECT 
     a.client_id                                    AS client_id, 
   a.loc_sid                                      AS store_id,  
   cry.currency_iso_cd                            AS currency_iso_cd, 
   a.dwh_cal_dt                                   AS dat_formdate,  
   a.sales_gross_val / cry.rate_currency_exchange AS val_retail_asis_ber, 
   a.sales_net_val / cry.rate_currency_exchange   AS val_retail_net_asis_ber, 
   a.cnt_customer                                 AS cnt_customer_asis_ber  
   FROM p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_2 a 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 cry 
   ON a.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
   INNER JOIN p_lew_core_ac.v_wawi_org_store_act_2 b  
   ON a.client_id = b.client_id 
   AND a.loc_sid = b.st_loc_sid 
   AND b.test_store_fg = 0  
   AND CURRENT_DATE >= b.dat_opening  
   INNER JOIN p_lew_core_ac.v_wawi_org_all_store_reloc_act_2 c  
   ON a.client_id = c.client_id 
   AND a.loc_sid = c.st_loc_sid 
  
 WHERE  
   (  
     (a.dwh_cal_dt BETWEEN b.dat_calc_start_py AND b.dat_calc_end_py) 
     OR (a.dwh_cal_dt >= b.dat_calc_start_py AND c.move_fg = 1) 
     OR (a.dwh_cal_dt >= b.dat_calc_start_py AND b.dat_calc_end_py IS NULL) 
   )  
;
