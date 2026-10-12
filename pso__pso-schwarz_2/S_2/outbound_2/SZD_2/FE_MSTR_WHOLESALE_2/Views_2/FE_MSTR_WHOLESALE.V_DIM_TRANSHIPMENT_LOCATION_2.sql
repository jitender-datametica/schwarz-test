CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_transhipment_location_2 (location_sid, country_location_sid,
iso_country_cd, country_name_de, country_name_en, transhipment_location_cd, transhipment_location_name, city_name,
transhipment_location_type_cd, transhipment_location_type_name) AS SELECT location_sid,
 country_location_sid,
 iso_country_cd,
 country_name_de,
 country_name_en,
 transhipment_location_cd,
 transhipment_location_name,
 city_name,
 transhipment_location_type_cd,
 transhipment_location_type_name
FROM szd_core.t_dim_transhipment_location_2
WHERE dwh_valid_fg;