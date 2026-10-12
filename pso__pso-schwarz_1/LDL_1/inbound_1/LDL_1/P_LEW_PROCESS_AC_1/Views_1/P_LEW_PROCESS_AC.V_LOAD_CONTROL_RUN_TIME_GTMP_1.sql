CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_LOAD_CONTROL_RUN_TIME_GTMP_1
( script_start_tms
, script_start_dt
)
AS
   SELECT
     script_start_tms,
   script_start_dt
  FROM p_lew_process.t_load_control_run_time_gtmp_1
;