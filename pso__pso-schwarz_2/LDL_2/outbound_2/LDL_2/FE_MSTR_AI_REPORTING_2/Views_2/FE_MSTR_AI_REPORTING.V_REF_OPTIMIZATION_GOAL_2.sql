CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_ref_optimization_goal_2 (opt_goal_sid, opt_goal_type_cd, opt_goal_value
) AS SELECT opt_goal_sid,
 opt_goal_type_cd,
 opt_goal_value
FROM ldl_p_lew_core.t_ref_optimization_goal_2;