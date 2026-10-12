CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_l_lifecycle_rvm_machine_winding AS SELECT rvm_winding_cd,
 rvm_winding_descr_de,
 rvm_winding_descr_en,
 rvm_winding_descr
FROM szd_core.t_dim_rvm_winding;