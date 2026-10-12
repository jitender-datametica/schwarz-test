CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_action_type_1 AS SELECT action_type_id,
 action_type_descr,
 mstr_related_fg,
 action_type_sort_val
FROM ldl_p_lew_mart_analytics.t_action_type_1;