CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_ROLLING_YEAR
  /* 	
 #DescStart# 	
 #$Revision: 12835 $, $LastChangedBy: umeister $ 	
 #SubjectAreas#: calendar 	
 #DescEnd# 	
 */	
(	
 month_until_id	
 , month_until_sequence	
 , rolling_year_type_id	
 , rolling_month_id	
  )	
AS	
   SELECT	
       month_until_id,	
   month_until_sequence,	
   rolling_year_type_id,	
   rolling_month_id	
   FROM p_lew_mart_msi.t_cal_rolling_year	
;