CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_crossdock_1 AS SELECT crossdock_sid,
 operating_hauler_sid,
 country_cd,
 crossdock_nr,
 crossdock_abbr_name,
 crossdock_name,
 longitude,
 latitude,
 city_name,
 zip,
 street_name,
 gln_nr,
 country_descr
FROM ldl_score_core.t_dim_crossdock_1;