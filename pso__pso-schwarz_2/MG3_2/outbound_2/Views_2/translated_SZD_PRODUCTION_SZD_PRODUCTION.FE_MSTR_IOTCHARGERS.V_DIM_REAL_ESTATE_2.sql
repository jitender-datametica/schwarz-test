CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_dim_real_estate_2 (real_estate_nr, zip, city, street, latitude
, longitude) AS SELECT real_estate_nr,
 zip,
 city,
 street,
 latitude,
 longitude
FROM szd_production_core.t_dim_real_estate_2
WHERE dwh_valid_fg;