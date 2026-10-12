CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_35_PREV_DAY as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Reichweite 	
   #DescEnd# 	
   */	
   SELECT	
   dat_calendar,	
   dat_calendar_35_prev_day	
    FROM p_lew_core_ac.v_wawi_cal_35_prev_day;