CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_agc_core_table_update_2 (
core_table_name STRING(100) COLLATE 'und:ci' NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
recalc_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
create_timestamp DATETIME,
dwh_load_id BIGNUMERIC(38,0),
PRIMARY KEY (client_id, dwh_cal_dt, recalc_fg) NOT ENFORCED
);