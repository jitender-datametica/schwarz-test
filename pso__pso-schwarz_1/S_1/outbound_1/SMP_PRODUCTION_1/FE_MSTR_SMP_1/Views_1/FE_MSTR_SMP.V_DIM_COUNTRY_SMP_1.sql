CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_country_smp_1 (division_id, country_id, country_name_fe,
country_division_id, star_active_fg) AS SELECT division_id,
 country_id,
  CASE
  WHEN country_name LIKE 'CLIENT: LIDL-LAND_1%'
  THEN REPLACE(country_name, 'CLIENT: LIDL-LAND_1 ', '') || ' ' || 'LDL'
  ELSE country_name || ' ' || 'KL'
  END AS country_name_fe,
 CONCAT(country_id, ':', division_id) AS country_division_id,
 star_active_fg
FROM smp_production_core_rel.t_country_1
WHERE star_active_fg = 1;