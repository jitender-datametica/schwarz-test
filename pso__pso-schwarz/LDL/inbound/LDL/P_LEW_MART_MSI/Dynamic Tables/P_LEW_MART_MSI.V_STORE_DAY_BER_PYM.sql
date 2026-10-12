
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STORE_DAY_BER_PYM 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*   
   #DescStart#  
   #$Revision: 6464 $, $LastChangedBy: aarnold $    
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)  
   #DescEnd#    
   */   
   SELECT   
       a11.client_id,   
   a11.loc_sid_store     AS store_id,   
   a11.currency_iso_cd, 
   a12.dat_calendar_amd  dat_formdate,  
   a11.val_retail_asis     AS val_retail_asis_ber,  
   a11.val_retail_net_asis AS val_retail_net_asis_ber,  
   a11.cnt_customer_asis   AS cnt_customer_asis_ber 
  FROM p_lew_bil_ac.v_agg_str_day_ejr_txj_ww_asis AS a11    
   INNER JOIN p_lew_mart_msi.v_cal_month_ber AS a12 
   ON (a11.dat_formdate = a12.dat_calendar_pyd) 
   INNER JOIN p_lew_mart_msi.v_org_all_store_reloc AS a13   
   ON (a11.client_id = a13.client_id    
   AND a11.loc_sid_store = a13.store_id)    
   INNER JOIN p_lew_core_ac.v_wawi_org_store AS a14 
   ON (a13.client_id = a14.client_id    
   AND a13.store_id = a14.st_loc_sid)   
   AND a14.test_store_fg = 0    
   AND CURRENT_DATE >= a14.dat_opening  
WHERE ( 
(a12.dat_calendar_amd >=  a14.dat_calc_start_py AND a13.move_fg = 1)    
OR a12.dat_calendar_amd BETWEEN a14.dat_calc_start_py AND a14.dat_calc_end_py   
OR (a12.dat_calendar_amd >=  a14.dat_calc_start_py AND a14.dat_calc_end_py IS NULL) 
)   
;
