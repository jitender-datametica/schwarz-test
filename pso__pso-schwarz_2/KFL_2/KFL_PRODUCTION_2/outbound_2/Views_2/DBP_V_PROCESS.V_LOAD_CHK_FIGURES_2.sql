CREATE OR REPLACE VIEW kfl_production_dbp_v_process.v_load_chk_figures_2 AS SELECT cycle_id,
 sql_name,
 sql_type,
 record_count,
 durationsec,
 err_count,
 job_name,
 scr_name,
 loop_id,
 proc_type
FROM kfl_production_dbp_process.load_chk_figures_2;