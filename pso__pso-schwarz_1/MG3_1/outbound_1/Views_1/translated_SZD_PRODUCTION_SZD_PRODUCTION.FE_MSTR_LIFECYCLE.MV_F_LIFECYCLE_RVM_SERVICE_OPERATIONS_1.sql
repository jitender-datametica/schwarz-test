CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_service_operations_1 (rvm_sid, prev_action_dt,
rvm_prev_action_type_id) AS SELECT rvm_sid,
 prev_action_dt,
 rvm_prev_action_type_id
FROM szd_production_core.t_fact_rvm_prev_actions_1
GROUP BY rvm_sid,
 prev_action_dt,
 rvm_prev_action_type_id;