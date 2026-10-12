CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_MONTH_CUM
  /* 	
 #DescStart# 	
 #$Revision: 12835 $, $LastChangedBy: umeister $ 	
 #SubjectAreas#: calendar 	
 #DescEnd# 	
 */	
(	
 cy_month	
 , month_byr_cum	
 , month_prev_byr_cum	
 , month_pprev_byr_cum	
  )	
AS	
   SELECT	
       cy_month,	
   month_byr_cum,	
   month_prev_byr_cum,	
   month_pprev_byr_cum	
   FROM p_lew_mart_msi.t_cal_month_cum	
;