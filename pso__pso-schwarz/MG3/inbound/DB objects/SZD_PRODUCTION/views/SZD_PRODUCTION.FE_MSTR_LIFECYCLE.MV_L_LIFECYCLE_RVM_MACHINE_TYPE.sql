create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MACHINE_TYPE(
	RVM_TYPE_CD,
	MANUFACTURER_SID,
	RVM_TYPE_NAME
) as SELECT 
 core.t_dim_rvm_type.rvm_type_cd
,core.t_dim_rvm_type.manufacturer_sid
,MAX(core.t_dim_rvm_type.rvm_type_name) AS rvm_type_name
FROM 
core.t_dim_rvm_type
GROUP BY 1,2
;