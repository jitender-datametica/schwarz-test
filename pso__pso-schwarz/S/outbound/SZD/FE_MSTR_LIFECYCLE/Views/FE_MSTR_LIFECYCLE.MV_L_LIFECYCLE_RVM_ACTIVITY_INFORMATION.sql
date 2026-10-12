-- 27.11.2023 twie: new dimension table

CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_l_lifecycle_rvm_activity_information (rvm_active_id, rvm_active_name_en
, rvm_active_name_de, rvm_active_name) AS SELECT rvm_active_id,
 rvm_active_name_en,
 rvm_active_name_de,
 rvm_active_name
FROM szd_core.t_dim_rvm_activity_information;