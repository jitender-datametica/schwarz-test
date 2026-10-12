CREATE OR REPLACE DYNAMIC TABLE P_LEW_PROCESS_MSTR.V_AGG_NVGTN_SRCH_DUMMY
(
  cy_month
, dummy_week
, one_week_fg
)
TARGET_LAG = '1 hour, 30 minutes' -- dummy value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_PROCESS_MSTR
AS
   SELECT
     c.cy_month,
   d.cy_week,
   1 AS one_week_fg
  FROM p_lew_mart_msi_ac.v_cal_calendarday c
   CROSS JOIN (
   SELECT cy_week
   FROM p_lew_mart_msi_ac.v_cal_week
   WHERE cy_week_sequence = -499
  ) AS d
WHERE dat_calendar = CURRENT_DATE - INTERVAL '1 day'
;