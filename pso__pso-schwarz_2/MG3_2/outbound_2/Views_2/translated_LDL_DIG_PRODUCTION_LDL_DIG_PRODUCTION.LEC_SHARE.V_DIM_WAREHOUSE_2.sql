CREATE OR REPLACE VIEW ldl_dig_production_lec_share.v_dim_warehouse_2 (wh_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
dwh_valid_fg, wh_cd, wh_name, wh_type_cd, is_run_by_ext_company, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name,
src_file_tmsp, src_table_name, wh_storage_type_cd, is_wine_storage_fg) AS SELECT *
FROM ldl_dig_production_core.t_dim_warehouse_2;