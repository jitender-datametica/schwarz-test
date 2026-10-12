
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_WEEK_TO_MTH_INT 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 6244 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: KPGES Views   
   #DescEnd#   
   */ 
   SELECT   
   iw.indicator_id,  
   cw.cy_month,   
   SUM(iw.val_indicator)   
   OVER (PARTITION BY iw.indicator_id, cw.cy_month, cw.cy_week, iw.dat_dayend) AS val_indicator,   
   SUM(iw.val_indicator)   
   OVER (PARTITION BY iw.indicator_id, cw.cy_month, iw.dat_dayend) AS val_indicator_sum_all, 
   COUNT(cw.cy_week) 
   OVER (PARTITION BY iw.client_id, iw.indicator_id, cw.cy_month, iw.dat_dayend) AS count_weeks,   
   iw.dat_dayend  
   
   FROM p_lew_core_ac.v_wawi_indicator_week AS iw  
   INNER JOIN (   
   SELECT cy_month,  
   cy_week  
   FROM p_lew_core_ac.v_wawi_cal_calendarday 
   WHERE (cy_month, cy_week) NOT IN (  
   SELECT cmth.prev_month, 
   MIN(cday.cy_week) 
   FROM p_lew_core_ac.v_wawi_cal_calendarday AS cday  
   INNER JOIN p_lew_core_ac.v_wawi_cal_month AS cmth  
   ON cday.cy_month = cmth.cy_month 
   GROUP BY cmth.prev_month   
   )  
   GROUP BY cy_month, cy_week 
   ) AS cw  
   ON  iw.cy * 100 + iw.cal_week = cw.cy_week   
   AND iw.org_type_id = 10 
   AND iw.indicator_type_id = 1  
   
   QUALIFY cw.cy_week = MAX(cw.cy_week) OVER (PARTITION BY iw.client_id, iw.indicator_id, cw.cy_month, iw.dat_dayend)   
;
