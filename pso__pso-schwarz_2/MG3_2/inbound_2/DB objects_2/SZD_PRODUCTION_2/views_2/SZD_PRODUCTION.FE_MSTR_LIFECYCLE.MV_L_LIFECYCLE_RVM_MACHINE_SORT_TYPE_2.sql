create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MACHINE_SORT_TYPE_2(
	RVM_SORT_TYPE_CD,
	RVM_SORT_TYPE_DESCR_EN,
	RVM_SORT_TYPE_DESCR_DE,
	RVM_SORT_TYPE_DESCR
) as SELECT 
 core.t_dim_rvm_sort_type.rvm_sort_type_cd
,core.t_dim_rvm_sort_type.rvm_sort_type_descr_en
,core.t_dim_rvm_sort_type.rvm_sort_type_descr_de
,core.t_dim_rvm_sort_type.rvm_sort_type_descr
FROM 
core.t_dim_rvm_sort_type_2
;