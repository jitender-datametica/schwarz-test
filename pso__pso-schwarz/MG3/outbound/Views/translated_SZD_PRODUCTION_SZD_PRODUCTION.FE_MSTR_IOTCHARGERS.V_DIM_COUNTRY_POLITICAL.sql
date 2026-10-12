CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_dim_country_political (iso_country_cd, country_name_en,
country_name_de, curr_cd, latitude, longitude, eu_member_fg, country_flag) AS SELECT iso_country_cd,
 country_name_en,
 country_name_de,
 curr_cd,
 latitude,
 longitude,
 eu_member_fg,
 CONCAT('https://mis', CASE
   WHEN udf_schema.PROJECT_ID() = 'SZD_PRODUCTION'
   THEN ''
   WHEN udf_schema.PROJECT_ID() = 'SZD_QUALITY'
   THEN '-qas'
   ELSE '-dev'
   END, '.schwarz/MicroStrategy/images/_custom/iotchargers/flags/', CASE
   WHEN iso_country_cd <> '-1'
   THEN iso_country_cd
   ELSE 'UNKNOWN'
   END, '.png') AS country_flag
FROM szd_production_core.t_dim_country_political
WHERE dwh_valid_fg;