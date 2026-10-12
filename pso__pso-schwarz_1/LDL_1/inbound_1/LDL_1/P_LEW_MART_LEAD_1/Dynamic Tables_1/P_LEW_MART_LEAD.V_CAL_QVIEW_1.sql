	CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_CAL_QVIEW_1
	(
  dspy_dt
, cal_dt
, cy_py_ind
, cy_week
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD
AS
   SELECT
         cal_dt AS dspy_dt
   ,cal_dt
   ,'C' AS cy_py_ind
   ,cy_week
  FROM p_lew_core_ac.v_cal_calendarday_1
  WHERE cy_day_seq BETWEEN -21 AND 0

  UNION ALL

  SELECT
        cal_dt AS dspy_dt
   ,cal_dt_swday_prev_1y AS cal_dt
   ,'P' AS cy_py_ind
   ,cy_week
  FROM p_lew_core_ac.v_cal_calendarday_1
  WHERE cy_day_seq BETWEEN -21 AND 0
;