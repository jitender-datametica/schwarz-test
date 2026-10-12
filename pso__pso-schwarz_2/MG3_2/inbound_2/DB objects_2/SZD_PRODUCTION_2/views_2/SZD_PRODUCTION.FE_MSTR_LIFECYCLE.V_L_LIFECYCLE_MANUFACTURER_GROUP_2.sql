create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_MANUFACTURER_GROUP_2(
	MANUFACTURER_GROUP_NAME,
	MANUFACTURER_GROUP_CD
) as SELECT 
 core.t_dim_manufacturer_group.manufacturer_group_name
,core.t_dim_manufacturer_group.manufacturer_group_cd
FROM 
core.t_dim_manufacturer_group_2
;