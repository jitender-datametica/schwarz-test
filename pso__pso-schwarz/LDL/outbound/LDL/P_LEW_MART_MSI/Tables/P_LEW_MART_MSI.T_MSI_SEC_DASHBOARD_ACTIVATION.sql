CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_sec_dashboard_activation (
dashboard_name STRING(128) COLLATE 'und:ci' NOT NULL,
dashboard_active_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);