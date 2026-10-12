CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_proc_wawi_int_1 (src_table, src_database, src_type, tgt_table, tgt_database
, tgt_create_fg) AS SELECT src_table,
 src_database,
 src_type,
 tgt_table,
 tgt_database,
 tgt_create_fg
FROM ldl_p_lew_process.t_proc_wawi_int_1;