CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_lidlplus_config_client_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
country_cd STRING(20) COLLATE 'und:ci' NOT NULL,
rollout_start_dt DATE NOT NULL,
full_client_rollout_dt DATE NOT NULL,
reporting_start_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id) NOT ENFORCED
);