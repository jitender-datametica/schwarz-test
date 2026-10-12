CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_CALENDARYEAR
  /* 	
 #DescStart# 	
 #$Revision: 12835 $, $LastChangedBy: umeister $ 	
 #SubjectAreas#: calendar 	
 #DescEnd# 	
 */	
(	
 cy	
 , prev_cy	
 , cy_year_sequence	
  )	
AS	
   SELECT	
        cy,	
   prev_cy,	
   cy_year_sequence	
  FROM p_lew_mart_msi.t_cal_calendaryear	
;