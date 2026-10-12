CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_country_1 (country_cd, country_name, country_iso3_cd) AS SELECT
 country_cd,
 country_name,
 country_iso3_cd
FROM ldl_dig_lec_share.v_dim_country_1
UNION ALL
SELECT '-1',
 '',
 '';