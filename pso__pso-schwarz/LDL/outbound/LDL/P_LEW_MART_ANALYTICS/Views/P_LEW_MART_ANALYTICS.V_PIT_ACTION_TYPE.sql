CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_pit_action_type AS SELECT action_type_id,
 action_type_descr,
 action_type_sort_val
FROM ldl_p_lew_mart_analytics.t_action_type;