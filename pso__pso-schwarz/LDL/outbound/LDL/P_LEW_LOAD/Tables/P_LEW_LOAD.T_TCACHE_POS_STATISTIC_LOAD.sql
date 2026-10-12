CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_pos_statistic_load (
context_load_id BIGNUMERIC(38) NOT NULL,
context_country STRING(3) COLLATE 'und:ci' NOT NULL,
orig_wh_nr BIGNUMERIC(38) NOT NULL,
orig_store_nr INTEGER NOT NULL,
extraction_dt DATE NOT NULL,
checker_id BIGNUMERIC(38) NOT NULL,
checker_state BIGNUMERIC(38) NOT NULL,
audit_nr BIGNUMERIC(38) NOT NULL,
dwh_mapping_dt DATE NOT NULL,
pos_terminal_id BIGNUMERIC(38) NOT NULL,
timestamp_running DATETIME,
stat_code BIGNUMERIC(38) NOT NULL,
stat_count BIGNUMERIC(38) NOT NULL,
val_stat_amount NUMERIC(18,4) NOT NULL,
dwh_load_id BIGNUMERIC(38) NOT NULL,
dc_server_id BIGNUMERIC(38) NOT NULL
);