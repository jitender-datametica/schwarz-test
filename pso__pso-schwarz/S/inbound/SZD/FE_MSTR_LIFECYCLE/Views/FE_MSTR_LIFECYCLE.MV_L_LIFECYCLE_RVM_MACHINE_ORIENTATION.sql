CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MACHINE_ORIENTATION 
AS SELECT 
 core.t_dim_rvm_orientation.rvm_orientation_cd
 ,core.t_dim_rvm_orientation.rvm_orientation_descr_en
 ,core.t_dim_rvm_orientation.rvm_orientation_descr_de
 ,core.t_dim_rvm_orientation.rvm_orientation_descr
FROM 
core.t_dim_rvm_orientation
;