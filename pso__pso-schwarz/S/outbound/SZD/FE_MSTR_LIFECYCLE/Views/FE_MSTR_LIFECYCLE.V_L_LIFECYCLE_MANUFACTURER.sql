CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_manufacturer AS SELECT manufacturer_name,
 manufacturer_sid,
 manufacturer_group_cd
FROM szd_core.t_dim_manufacturer;