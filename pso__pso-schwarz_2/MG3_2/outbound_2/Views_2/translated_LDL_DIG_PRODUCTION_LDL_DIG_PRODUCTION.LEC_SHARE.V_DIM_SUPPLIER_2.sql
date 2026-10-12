CREATE OR REPLACE VIEW ldl_dig_production_lec_share.v_dim_supplier_2 (supplier_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp
, dwh_valid_fg, supplier_nr, supplier_name, addr_sid, orig_country_cd, dwh_created_tmsp, dwh_updated_tmsp,
dwh_src_file_name, src_file_tmsp, src_table_name, supplier_full_name, zip_cd, city_name, street_name,
supplier_src_insert_dt) AS SELECT *
FROM ldl_dig_production_core.t_dim_supplier_2;