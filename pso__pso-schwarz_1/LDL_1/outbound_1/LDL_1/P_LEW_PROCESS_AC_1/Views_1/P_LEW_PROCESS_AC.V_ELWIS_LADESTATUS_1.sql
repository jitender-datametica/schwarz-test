CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_elwis_ladestatus_1 (country_1, extr_type, dat_dayend, run_endtime, extr_soll,
extr_succ, load_succ, extr_failed, dwh_load_id, dwh_created, dwh_updated) AS SELECT country_1,
 extr_type,
 dat_dayend,
 run_endtime,
 extr_soll,
 extr_succ,
 load_succ,
 extr_failed,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_elwis_ladestatus_1;