CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_DELTA_LOAD_STATUS
(
      delta_name
    , delta_timestamp_val
)
AS
   SELECT
         delta_name,
   delta_timestamp_val
  FROM p_lew_mart_analytics.t_delta_load_status
;