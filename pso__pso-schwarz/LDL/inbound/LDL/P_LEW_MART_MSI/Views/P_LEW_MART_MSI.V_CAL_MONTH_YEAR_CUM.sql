CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_MONTH_YEAR_CUM as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Kalender 	
   #DescEnd# 	
   */	
   SELECT	
   cy_month,	
   cy_month_year_cum,	
   cy_month_year_cum_py,	
   cy_month_year_cum_ppy	
   FROM p_lew_core_ac.v_wawi_cal_month_year_cum	
;