CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_PARAM_1

AS
   SELECT
   param_id
,   dwh_valid_from
,   dwh_valid_to
,   param_name
,   param_value
   FROM p_lew_mart_pit_onprem.t_pit_param_1
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to;