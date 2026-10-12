
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_YEAR_2 
 /* 
 #DescStart# 
 #$Revision: 12250 $, $LastChangedBy: gkunz $ 
 #SubjectAreas#:
 #DescEnd# 
 */ 
(
per_yr
,liam_avbl_fg
,lift_avbl_fg
) 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
 AS 
 SELECT 
 CAST(pc.period_year AS SMALLINT) AS per_yr
 ,Max(pp.liam_avbl_fg) AS liam_avbl_fg 
 ,Max(pp.lift_avbl_fg) AS lift_avbl_fg 
 FROM p_lew_core_ac.v_lil_period_2 AS pc
 INNER JOIN p_lew_process_mstr_ac.v_lil_period_2 AS pp
 ON pp.period_sid = pc.period_sid
 GROUP BY pc.period_year;
