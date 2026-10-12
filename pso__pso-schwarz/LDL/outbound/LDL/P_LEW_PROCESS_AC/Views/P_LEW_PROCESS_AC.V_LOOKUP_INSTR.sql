CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_lookup_instr (lila, target_table, source_system, source_unique_name,
target_column, lkp_column, lkp_table, lkp_table_lkp_keys, source_lkp_keys, add_temporal_join, lkp_table_area) AS SELECT
 lila,
 target_table,
 source_system,
 source_unique_name,
 target_column,
 lkp_column,
 lkp_table,
 lkp_table_lkp_keys,
 source_lkp_keys,
 add_temporal_join,
 lkp_table_area
FROM ldl_p_lew_process.t_lookup_instr;