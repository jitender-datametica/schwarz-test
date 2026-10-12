CREATE OR REPLACE VIEW ldl_dig_production_fe_mstr_lidldigital.v_dim_country (country_cd, country_name, country_iso3_cd)
AS SELECT country_cd,
 country_name,
 country_iso3_cd
FROM ldl_dig_production_lec_share.v_dim_country
UNION ALL
SELECT '-1 as a ',
 'as b',
 'as c';