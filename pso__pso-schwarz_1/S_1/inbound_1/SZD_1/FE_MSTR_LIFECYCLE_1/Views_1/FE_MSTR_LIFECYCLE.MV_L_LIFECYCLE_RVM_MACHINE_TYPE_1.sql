CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MACHINE_TYPE_1 
AS SELECT 
 core.t_dim_rvm_type.rvm_type_cd
,core.t_dim_rvm_type.manufacturer_sid
,MAX(core.t_dim_rvm_type.rvm_type_name) AS rvm_type_name
FROM 
core.t_dim_rvm_type_1
GROUP BY 1,2
;