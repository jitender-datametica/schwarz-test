CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
threshold_group_id BIGNUMERIC(38,0) NOT NULL,
threshold_group_desc STRING(50) COLLATE 'und:ci',
min_val_retail_ejr NUMERIC(18,2),
max_val_retail_ejr NUMERIC(18,2),
requesting_user STRING(128) COLLATE 'und:ci' DEFAULT SESSION_USER() NOT NULL,
timestamp_request DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
approval_fg BIGNUMERIC(38,0) NOT NULL,
approval_user STRING(128) COLLATE 'und:ci',
timestamp_approval DATETIME,
approval2_user STRING(128) COLLATE 'und:ci',
timestamp_approval2 DATETIME
);