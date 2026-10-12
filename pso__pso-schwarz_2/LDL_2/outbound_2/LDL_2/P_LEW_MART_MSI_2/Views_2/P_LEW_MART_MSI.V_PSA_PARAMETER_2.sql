CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_psa_parameter_2 AS SELECT env_cd,
 report_id AS psa_report_id,
 withdrawal,
 report_from,
 report_until
FROM ldl_p_lew_process_ac.v_psa_report_parameter_2
GROUP BY env_cd,
 report_id,
 withdrawal,
 report_from,
 report_until;