CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_recalc_infos_1 (tablename, startdate, enddate, client_id) AS SELECT
 tablename,
 startdate,
 enddate,
 client_id
FROM ldl_p_lew_process.t_recalc_infos_1;