
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_DAY_CNT_WEEK_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
      SELECT      
      a.cy_week,  
      a.dat_calendar,   
      b.client_id,      
      c.wh_id,    
      COUNT (*) day_cnt 
      FROM p_lew_mart_msi.v_cal_calendarday_1 a   
      INNER JOIN p_lew_mart_msi.v_org_store_1 b   
      ON a.dat_calendar >= dat_opening_ovis     
      INNER JOIN p_lew_mart_msi.v_org_store_skey_1 c    
      ON b.client_id = c.client_id  
      AND b.store_id  =  c.store_id 
      WHERE 
      (a.dat_calendar <= dat_closing_ovis OR dat_closing_ovis IS NULL)  
      AND b.orig_store_nr <> c.wh_id      
      AND a.cy_day_sequence <= 0    
      GROUP BY 1,2,3,4  
;
