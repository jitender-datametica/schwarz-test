CREATE OR REPLACE VIEW ldl_dig_production_lec_share.v_dim_country_1 (country_cd, country_name, country_iso3_cd,
dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, src_file_tmsp) AS SELECT *
FROM ldl_dig_production_core.t_dim_country_1;