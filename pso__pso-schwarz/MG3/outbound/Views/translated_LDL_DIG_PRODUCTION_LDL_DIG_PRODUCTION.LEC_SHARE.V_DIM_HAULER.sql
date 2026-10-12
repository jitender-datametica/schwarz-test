CREATE OR REPLACE VIEW ldl_dig_production_lec_share.v_dim_hauler (hauler_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
dwh_valid_fg, hauler_name, hauler_country_cd, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, src_file_tmsp,
src_table_name) AS SELECT *
FROM ldl_dig_production_core.t_dim_hauler;