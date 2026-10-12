CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_item (country, item_nr, item_name, item_group_nr,
item_sub_group, item_sub_group_nr, item_family_group_nr, item_family_group, item_rlz_supplier, item_rlz_store,
item_rlz_warehouse, mod_date, source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_dim_item;