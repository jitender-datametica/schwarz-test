CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_EXPORT_LOG_AUDIMEX_2
(
    load_id
    , export_cluster_id
    , process_name
    , report_dt
    , report_days
    , report_mode
    , start_tmsp
    , end_tmsp
    , max_load_id
    , max_timestamp_delta
    , data_count
    , status_2
    , log_descr
)
AS
   SELECT
       load_id,
   export_cluster_id,
   process_name,
   report_dt,
   report_days,
   report_mode,
   start_tmsp,
   end_tmsp,
   max_load_id,
   max_timestamp_delta,
   data_count,
   status_2,
   log_descr
  FROM P_LEW_PROCESS.T_EXPORT_LOG_AUDIMEX_2
;