CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_f_lifecycle_rvm_service_operations AS SELECT rvm_sid,
 prev_action_dt,
 rvm_prev_action_type_id
FROM szd_core.t_fact_rvm_prev_actions
GROUP BY rvm_sid,
 prev_action_dt,
 rvm_prev_action_type_id;