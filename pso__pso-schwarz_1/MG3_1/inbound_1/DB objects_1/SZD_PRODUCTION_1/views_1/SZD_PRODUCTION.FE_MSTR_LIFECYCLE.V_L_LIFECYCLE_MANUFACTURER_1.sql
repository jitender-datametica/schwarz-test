create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_MANUFACTURER_1(
	MANUFACTURER_NAME,
	MANUFACTURER_SID,
	MANUFACTURER_GROUP_CD
) as SELECT 
 core.t_dim_manufacturer.manufacturer_name
,core.t_dim_manufacturer.manufacturer_sid
,core.t_dim_manufacturer.manufacturer_group_cd
FROM 
core.t_dim_manufacturer_1
;