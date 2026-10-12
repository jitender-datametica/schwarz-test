
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STORE_DAY_BER_PPYW_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*   
   #DescStart#  
   #$Revision: 7108 $, $LastChangedBy: pmittler $   
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)  
   #DescEnd#    
   */   
   SELECT   
        a.client_id,    
   a.loc_sid_store       AS store_id,   
   a.currency_iso_cd,   
   b.dat_calendar        AS dat_formdate,   
   a.val_retail_asis     AS val_retail_asis_ber,    
   a.val_retail_net_asis AS val_retail_net_asis_ber,    
   a.cnt_customer_asis   AS cnt_customer_asis_ber   
    
  FROM p_lew_bil_ac.v_agg_str_day_ejr_txj_ww_asis_1 AS a  
    
   JOIN p_lew_mart_msi.v_cal_calendarday_1 AS b   
   ON  (a.dat_formdate = b.ppy_dat_calendar)    
    
   JOIN p_lew_mart_msi.v_org_all_store_reloc_1 AS c   
   ON  (a.client_id = c.client_id   
   AND  a.loc_sid_store = c.store_id)   
    
   JOIN p_lew_core_ac.v_wawi_org_store_1 AS d 
   ON  (a.client_id = d.client_id   
   AND  a.loc_sid_store = d.st_loc_sid) 
   AND test_store_fg = 0    
   AND CURRENT_DATE >= dat_opening  
    
   WHERE    
   (    
       b.dat_calendar BETWEEN d.dat_calc_start_ppy AND ADD_MONTHS(d.dat_calc_end_py,12) 
       OR b.dat_calendar>=d.dat_calc_start_ppy AND c.move_fg=1  
       OR (b.dat_calendar>=d.dat_calc_start_ppy AND d.dat_calc_end_py IS NULL)  
   )    
;
