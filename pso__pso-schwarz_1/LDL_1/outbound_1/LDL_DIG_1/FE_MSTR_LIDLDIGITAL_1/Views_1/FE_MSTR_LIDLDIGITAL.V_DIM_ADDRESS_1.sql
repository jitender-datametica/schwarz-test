CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_address_1 (addr_sid, addr_nr, zip_cd, mstr_zip_cd, country_name,
city_name, street_name, house_nr, district_name, post_box_nr, addr_suffix, company_name, addr_lon, addr_lat,
addr_type_cd) AS SELECT addr_sid,
 addr_nr,
 zip_cd,
  CASE
  WHEN country_name = 'CZ' OR country_name = 'SK'
  THEN REPLACE(zip_cd, ' ', '')
  WHEN country_name = 'NL'
  THEN LEFT(zip_cd, LENGTH(zip_cd) - 3)
  ELSE zip_cd
  END AS mstr_zip_cd,
 country_name,
 city_name,
 street_name,
 house_nr,
 district_name,
 post_box_nr,
 addr_suffix,
 company_name,
 addr_lon,
 addr_lat,
 addr_type_cd
FROM ldl_dig_lec_share.v_dim_address_1
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 '',
 '',
 '',
 '',
 '',
 '',
 '',
 '',
 '',
 '',
 0,
 0,
 '-1';