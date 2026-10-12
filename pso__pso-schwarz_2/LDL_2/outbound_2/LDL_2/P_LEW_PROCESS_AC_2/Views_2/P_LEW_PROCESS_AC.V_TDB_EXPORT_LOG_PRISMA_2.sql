CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_tdb_export_log_prisma_2 (dwh_cal_dt, sap_cluster_cd) AS SELECT dwh_cal_dt,
 sap_cluster_cd
FROM ldl_p_lew_process.t_tdb_export_log_prisma_2;