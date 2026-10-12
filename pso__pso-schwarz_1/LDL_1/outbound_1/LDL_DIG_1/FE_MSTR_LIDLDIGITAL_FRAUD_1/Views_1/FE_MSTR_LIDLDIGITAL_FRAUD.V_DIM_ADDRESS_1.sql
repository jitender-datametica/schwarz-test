CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital_fraud.v_dim_address_1 AS SELECT addr_sid,
 addr_nr,
 zip_cd,
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
 addr_type_cd,
 CONCAT(street_name, ' ', house_nr, ' ', zip_cd, ' ', city_name) AS addr_string,
  LOWER(CONCAT(street_name, ' ', house_nr, ' ', zip_cd, ' ', city_name)) LIKE LOWER('%PACKSTATION%') AS
 is_packstation_fg
FROM ldl_dig_fe_mstr_lidldigital.v_dim_address_1;