CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_WEEK
 /*
 #DescStart#	
 #$Revision: 12835 $, $LastChangedBy: umeister $	
 #SubjectAreas#: calendar	
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
   cw.cy_week
   ,cw.cy_week_prev_1w AS prev_week
   ,cw.cy_week_prev_1y AS prev_cy_week
   ,cw.cy_week_prev_2y AS preprev_cy_week
   ,TRIM(TO_VARCHAR(TRUNC(cw.cy_week/100))) || ' KW ' || SUBSTRING('0'|| TO_VARCHAR(MOD(cw.cy_week, 100)),-2) AS cy_week_name
   ,'KW ' || SUBSTRING('0'||TO_VARCHAR(MOD(cw.cy_week, 100)),-2) AS cy_week_short_name
   ,cw.cy_week_seq AS cy_week_sequence
    FROM  p_lew_core_ac.v_cal_week cw
;