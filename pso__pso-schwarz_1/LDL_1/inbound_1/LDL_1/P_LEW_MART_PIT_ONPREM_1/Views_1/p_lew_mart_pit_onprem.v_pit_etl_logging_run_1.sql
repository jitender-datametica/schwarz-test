CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ETL_LOGGING_RUN_1

(
      run_id
    , run_ts
    , run_dt
)
AS
   SELECT
   run_id
,   run_ts
,   run_dt
   FROM p_lew_mart_pit_onprem.t_pit_etl_logging_run_1;