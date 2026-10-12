CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_PIT_PARAM_1
AS
   SELECT
     param_id,
   dwh_valid_from,
   dwh_valid_to,
   param_name,
   param_value
  FROM p_lew_mart_analytics.t_pit_param_1
  WHERE CURRENT_DATE BETWEEN dwh_valid_from and dwh_valid_to
;