CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_WEEK_1
 /* 	
 #DescStart# 	
 #$Revision: 12835 $, $LastChangedBy: umeister $ 	
 #SubjectAreas#: calendar_1 	
 #DescEnd# 	
 */	
(	
    cy_week	
    , prev_week	
    , prev_cy_week	
    , preprev_cy_week	
    , cy_week_name	
    , cy_week_short_name	
    , cy_week_sequence	
)	
AS	
   SELECT	
       cy_week,	
   prev_week,	
   prev_cy_week,	
   preprev_cy_week,	
   cy_week_name,	
   cy_week_short_name,	
   cy_week_sequence	
  FROM p_lew_mart_msi.t_cal_week_1	
;