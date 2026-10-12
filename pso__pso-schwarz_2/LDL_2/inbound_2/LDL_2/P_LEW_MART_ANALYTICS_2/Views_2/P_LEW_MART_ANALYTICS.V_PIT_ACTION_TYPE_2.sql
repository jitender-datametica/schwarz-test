CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_PIT_ACTION_TYPE_2
AS
SELECT
  action_type_id
, action_type_descr
, action_type_sort_val
FROM p_lew_mart_analytics.t_action_type_2;