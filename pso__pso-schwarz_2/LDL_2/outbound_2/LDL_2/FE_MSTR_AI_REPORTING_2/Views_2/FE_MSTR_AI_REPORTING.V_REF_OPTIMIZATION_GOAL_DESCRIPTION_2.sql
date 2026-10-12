CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_ref_optimization_goal_description_2 (client_id, opt_goal_sid,
opt_goal_descr) AS SELECT client_id,
 opt_goal_sid,
 opt_goal_descr
FROM ldl_p_lew_core.t_ref_optimization_goal_description_2;