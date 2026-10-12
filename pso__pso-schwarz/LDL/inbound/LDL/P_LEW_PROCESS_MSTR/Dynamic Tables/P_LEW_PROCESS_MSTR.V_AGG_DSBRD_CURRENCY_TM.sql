CREATE OR REPLACE DYNAMIC TABLE P_LEW_PROCESS_MSTR.V_AGG_DSBRD_CURRENCY_TM
(
  client_id
, currency_iso_cd
, curr_tot_id
, tm_lvl_id
, cy_week
, cy_month
, dummytime
)

TARGET_LAG = '1 hour, 30 minutes' -- dummy value; will be refreshed by Abinitio jobs
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_PROCESS_MSTR

AS
   SELECT
     cr.client_id,
   cr.currency_iso_cd,
   cr.curr_tot_id,
   tm.tm_lvl_id,
   tm.cy_week,
   tm.cy_month,
   CAST (1 AS BYTEINT) AS dummytime
  FROM p_lew_mart_msi_ac.v_ref_currency AS cr
   CROSS JOIN p_lew_process_mstr.t_agg_nvgtn_tm AS tm
   WHERE tm.tm_lvl_id IN (2,3)
;