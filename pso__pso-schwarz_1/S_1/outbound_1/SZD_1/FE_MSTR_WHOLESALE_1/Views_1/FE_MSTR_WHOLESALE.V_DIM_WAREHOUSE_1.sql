CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_warehouse_1 (wh_site_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
dwh_valid_fg, wh_name, wh_short_name, country_pol_cd, city_name) AS SELECT resource_item_sid AS wh_site_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 warehouse_name AS wh_name,
 warehouse_short_name AS wh_short_name,
 country_pol_cd,
 city_name
FROM szd_core.t_dim_external_warehouse_1
WHERE dwh_valid_fg;