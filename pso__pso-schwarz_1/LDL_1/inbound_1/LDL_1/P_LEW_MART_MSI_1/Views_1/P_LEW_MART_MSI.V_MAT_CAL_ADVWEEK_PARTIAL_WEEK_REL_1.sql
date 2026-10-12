CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_ADVWEEK_PARTIAL_WEEK_REL_1
 /* 
 #DescStart# 
 #$Revision: 17258 $, $LastChangedBy: abialek $ 
 #SubjectAreas#: calendar_1 
 #DescEnd# 
 */ 
 (
   cy_week
 , cy_week_partial_week_id1
 , cy_week_partial_week_id2
 , cy_week_partial_week_name
 , cy_month
 , byr
 , cy_week_partial_week_id
 )
 AS 
 SELECT 
 CASE WHEN cy_week_partial_week_id2 IN (1,2) THEN cy_week_partial_week_id1*10 + cy_week_partial_week_id2 
 ELSE cy_week_partial_week_id1 
 END AS cy_week 
 , cy_week_partial_week_id1 
 , cy_week_partial_week_id2 
 , cy_week_partial_week_name 
 , cy_month 
 , byr 
 , cy_week_partial_week_id 
 FROM p_lew_mart_msi.v_cal_week_partial_week_1
;
