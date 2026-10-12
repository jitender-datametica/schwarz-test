CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_load_control_app_act_tms_tmp_2 (
load_process_application_id BIGNUMERIC(38,0) NOT NULL,
load_process_sap_cluster_cd STRING(100) COLLATE 'und:ci' NOT NULL,
application_load_start_dt DATE NOT NULL,
application_load_start_tms DATETIME NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);