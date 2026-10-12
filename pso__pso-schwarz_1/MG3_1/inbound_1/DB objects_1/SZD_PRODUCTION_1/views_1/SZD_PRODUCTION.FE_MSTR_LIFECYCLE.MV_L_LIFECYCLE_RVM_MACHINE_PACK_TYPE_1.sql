create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MACHINE_PACK_TYPE_1(
	RVM_PACK_TYPE_CD,
	RVM_PACK_TYPE_DESCR_EN,
	RVM_PACK_TYPE_DESCR_DE,
	RVM_PACK_TYPE_DESCR
) as SELECT 
 core.t_dim_rvm_pack_type.rvm_pack_type_cd
,core.t_dim_rvm_pack_type.rvm_pack_type_descr_en
,core.t_dim_rvm_pack_type.rvm_pack_type_descr_de
,core.t_dim_rvm_pack_type.rvm_pack_type_descr
FROM 
core.t_dim_rvm_pack_type_1
;