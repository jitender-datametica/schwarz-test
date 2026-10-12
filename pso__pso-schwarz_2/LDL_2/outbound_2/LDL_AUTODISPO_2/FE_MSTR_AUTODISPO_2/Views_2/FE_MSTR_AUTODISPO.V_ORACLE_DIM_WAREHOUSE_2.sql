CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_warehouse_2 (country_2, ware_active, ware_id, ware_name
, ware_warehouse_id, mod_date, source_flag, adl_active_flag, source_extraction_tmsp, snflk_insert_tmsp,
snflk_update_tmsp) AS SELECT country_2,
 ware_active,
 ware_id,
 ware_name,
 ware_warehouse_id,
 mod_date,
 int_fc AS source_flag,
 adl_active AS adl_active_flag,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_dim_warehouse_2;