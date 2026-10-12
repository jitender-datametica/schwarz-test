create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MACHINE_ORIENTATION_2(
	RVM_ORIENTATION_CD,
	RVM_ORIENTATION_DESCR_EN,
	RVM_ORIENTATION_DESCR_DE,
	RVM_ORIENTATION_DESCR
) as SELECT 
 core.t_dim_rvm_orientation.rvm_orientation_cd
 ,core.t_dim_rvm_orientation.rvm_orientation_descr_en
 ,core.t_dim_rvm_orientation.rvm_orientation_descr_de
 ,core.t_dim_rvm_orientation.rvm_orientation_descr
FROM 
core.t_dim_rvm_orientation_2
;