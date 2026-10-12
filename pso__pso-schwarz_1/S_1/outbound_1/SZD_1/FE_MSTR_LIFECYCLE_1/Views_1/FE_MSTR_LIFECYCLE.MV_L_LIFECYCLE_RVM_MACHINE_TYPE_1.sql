CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_l_lifecycle_rvm_machine_type_1 AS SELECT rvm_type_cd,
 manufacturer_sid,
 MAX(rvm_type_name) AS rvm_type_name
FROM szd_core.t_dim_rvm_type_1
GROUP BY rvm_type_cd,
 manufacturer_sid;