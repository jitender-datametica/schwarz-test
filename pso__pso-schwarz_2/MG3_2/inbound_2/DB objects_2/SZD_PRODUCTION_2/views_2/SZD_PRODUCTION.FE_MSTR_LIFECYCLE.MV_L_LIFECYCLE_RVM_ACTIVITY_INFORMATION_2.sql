create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_ACTIVITY_INFORMATION_2(
	RVM_ACTIVE_ID,
	RVM_ACTIVE_NAME_EN,
	RVM_ACTIVE_NAME_DE,
	RVM_ACTIVE_NAME
) as
--27.11.2023 twie: new dimension table

SELECT
 core.t_dim_rvm_activity_information.rvm_active_id
,core.t_dim_rvm_activity_information.rvm_active_name_en
,core.t_dim_rvm_activity_information.rvm_active_name_de
,core.t_dim_rvm_activity_information.rvm_active_name
FROM 
core.t_dim_rvm_activity_information_2;