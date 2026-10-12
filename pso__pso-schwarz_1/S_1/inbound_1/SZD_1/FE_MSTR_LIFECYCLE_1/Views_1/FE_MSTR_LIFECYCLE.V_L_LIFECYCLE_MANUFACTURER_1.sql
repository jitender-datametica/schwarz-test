CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_MANUFACTURER_1 
AS SELECT 
 core.t_dim_manufacturer.manufacturer_name
,core.t_dim_manufacturer.manufacturer_sid
,core.t_dim_manufacturer.manufacturer_group_cd
FROM 
core.t_dim_manufacturer_1
;