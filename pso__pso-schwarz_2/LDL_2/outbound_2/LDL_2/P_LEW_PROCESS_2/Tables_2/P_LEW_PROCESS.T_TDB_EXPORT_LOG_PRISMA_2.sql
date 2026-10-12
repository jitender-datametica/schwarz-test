CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_tdb_export_log_prisma_2 (
dwh_cal_dt DATE NOT NULL,
sap_cluster_cd STRING(100) COLLATE 'und:ci' NOT NULL,
last_export_timestamp DATETIME
);