CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_current_execution_gtmp_1 (
load_id BIGNUMERIC(38,0) NOT NULL,
load_process_application_id BIGNUMERIC(38,0) NOT NULL,
load_process_sap_cluster_cd STRING(100) COLLATE 'und:ci' NOT NULL,
load_process STRING(50) COLLATE 'und:ci',
load_type STRING(5) COLLATE 'und:ci',
load_start_dt DATE NOT NULL,
load_start_tms DATETIME NOT NULL,
load_end_dt DATE,
load_end_tms DATETIME,
enforce_single_row BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
);