CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_store (store_address, store_so_id, mod_date,
store_open_day, store_nr, store_wh, country, store_size, store_type, store_close_day, store_active, deleted,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_dim_store
WHERE deleted = 0;