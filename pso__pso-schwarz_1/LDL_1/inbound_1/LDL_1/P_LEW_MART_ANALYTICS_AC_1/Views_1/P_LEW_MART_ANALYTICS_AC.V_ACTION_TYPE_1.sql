CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ACTION_TYPE_1
AS
   SELECT
     action_type_id,
   action_type_descr,
   mstr_related_fg,
   action_type_sort_val
  FROM p_lew_mart_analytics.t_action_type_1;