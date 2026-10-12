CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_FIVE_PREV_WEEKS_PY
  /* 	
 #DescStart# 	
 #$Revision: 12835 $, $LastChangedBy: umeister $ 	
 #SubjectAreas#: calendar 	
 #DescEnd# 	
 */	
(	
 cy_week	
 , prev_week	
 , prev_week_py	
 , diff_week_sequence	
  )	
AS	
   SELECT	
       cy_week,	
   prev_week,	
   prev_week_py,	
   diff_week_sequence	
   FROM p_lew_mart_msi.t_cal_five_prev_weeks_py	
;