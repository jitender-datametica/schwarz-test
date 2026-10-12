CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_psa_report_parameter_1 (env_cd, report_id, withdrawal, report_from,
report_until) AS SELECT env_cd,
 report_id,
 withdrawal,
 report_from,
 report_until
FROM ldl_p_lew_process.t_psa_report_parameter_1;