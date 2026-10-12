TRUNCATE TABLE szd_production_core.t_dim_rvm_prev_actions_type;


INSERT INTO szd_production_core.t_dim_rvm_prev_actions_type (rvm_prev_action_type_id, rvm_prev_action_type_descr,
 rvm_prev_action_type_descr_en, rvm_prev_action_type_descr_de, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_rvm_prev_actions_type_temp);


COMMIT TRANSACTION;