CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_dim_country_political (location_sid, iso_country_cd,
country_name_de, country_name_en, curr_cd, latitude, longitude) AS SELECT location_sid,
 iso_country_cd,
 country_name_de,
 country_name_en,
 curr_cd,
 latitude,
 longitude
FROM szd_production_core.t_dim_country_political
WHERE dwh_valid_fg;