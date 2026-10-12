CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MANUFACTURER_1 
AS SELECT 
 core.t_dim_rvm_manufacturer.rvm_manufacturer_name
,core.t_dim_rvm_manufacturer.rvm_manufacturer_id
FROM 
core.t_dim_rvm_manufacturer
;