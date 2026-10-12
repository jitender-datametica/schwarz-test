CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_l_lifecycle_rvm_machine_type (rvm_type_cd, manufacturer_sid,
rvm_type_name) AS SELECT rvm_type_cd,
 manufacturer_sid,
 MAX(rvm_type_name) AS rvm_type_name
FROM szd_production_core.t_dim_rvm_type
GROUP BY rvm_type_cd,
 manufacturer_sid;