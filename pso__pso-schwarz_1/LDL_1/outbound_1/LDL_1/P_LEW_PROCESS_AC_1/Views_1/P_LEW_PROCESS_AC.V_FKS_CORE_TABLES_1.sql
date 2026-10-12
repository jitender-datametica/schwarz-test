CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_fks_core_tables_1 (refkey_name, refkey_type, refkey_owner_table_name,
references_table_name) AS SELECT refkey_name,
 refkey_type,
 refkey_owner_table_name,
 references_table_name
FROM ldl_p_lew_process.t_fks_core_tables_1;