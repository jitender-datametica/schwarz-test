create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MACHINE_WINDING_1(
	RVM_WINDING_CD,
	RVM_WINDING_DESCR_DE,
	RVM_WINDING_DESCR_EN,
	RVM_WINDING_DESCR
) as SELECT
 core.t_dim_rvm_winding.rvm_winding_cd
 ,core.t_dim_rvm_winding.rvm_winding_descr_de
 ,core.t_dim_rvm_winding.rvm_winding_descr_en
 ,core.t_dim_rvm_winding.rvm_winding_descr
FROM 
core.t_dim_rvm_winding_1
;