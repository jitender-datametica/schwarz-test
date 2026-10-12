CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_PARAM_2
AS
   SELECT
     param_id,
   dwh_valid_from,
   dwh_valid_to,
   param_name,
   param_value
  FROM p_lew_mart_analytics.v_pit_param_2
;