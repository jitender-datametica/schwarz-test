CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_airport_2 (airport_cd, country_cd, airport_city_name) AS SELECT
 airport_cd,
 IFNULL(country_cd, '-1') AS country_cd,
 airport_city_name
FROM ldl_dig_lec_share.v_dim_airport_2
UNION ALL
SELECT '-1',
 '-1',
 '';