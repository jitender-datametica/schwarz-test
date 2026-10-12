
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_WEEK_TO_MTH_COUNTRY 

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
      client_id,  
      indicator_id,     
      cy_month,   
      val_indicator,    
      SUM(val_indicator)      
      OVER (PARTITION BY client_id, indicator_id, cy_month, currency_iso_cd, dat_dayend) AS val_indicator_sum_all,      
      COUNT(cy_week)    
      OVER (PARTITION BY client_id, indicator_id, cy_month, currency_iso_cd, dat_dayend) AS count_weeks,    
      currency_iso_cd,  
      dat_dayend  
      
      FROM (      
      SELECT      
      iw.client_id,     
      iw.indicator_id,  
      cw.cy_month,      
      cw.cy_week, 
      cry.currency_iso_cd,    
      iw.dat_dayend,    
      SUM(CASE WHEN iw.indicator_id IN (  
      117, 120, 125, 126, 133, 135, 136, 155, 156, 157,     
      163, 168, 169, 170, 172, 174, 177, 179, 203, 204,     
      209, 210, 212, 216, 228, 229, 230, 238, 240, 242,     
      250, 251, 255, 256, 257, 258, 259, 260, 261, 270,     
      271, 272, 273, 280, 281, 282, 283, 284, 286)    
      THEN iw.val_indicator / cry.rate_currency_exchange    
      ELSE iw.val_indicator   
      END) AS val_indicator   
      
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
      AND iw.org_type_id = 20 
      AND iw.indicator_type_id = 1  
      INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry   
      ON  iw.client_id = cry.client_id    
      AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end    
      
      GROUP BY    
      iw.client_id      
      , iw.indicator_id 
      , cw.cy_month     
      , cw.cy_week      
      , cry.currency_iso_cd   
      , iw.dat_dayend   
      ) AS t      
      QUALIFY cy_week = MAX(cy_week) OVER (PARTITION BY client_id, indicator_id, cy_month, currency_iso_cd, dat_dayend) 
;
