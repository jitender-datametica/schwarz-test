CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_psa_report_stores_2 (env_cd, report_id, country_iso_cd, store_nr) AS SELECT
 env_cd,
 report_id,
 country_iso_cd,
 store_nr
FROM ldl_p_lew_process.t_psa_report_stores_2;