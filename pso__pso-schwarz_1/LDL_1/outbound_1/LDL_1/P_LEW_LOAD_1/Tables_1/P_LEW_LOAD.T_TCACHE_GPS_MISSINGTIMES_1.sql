CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_gps_missingtimes_1 (
client_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
orig_store_nr INTEGER NOT NULL,
time_record_id BIGNUMERIC(38) NOT NULL,
time_record_change_dt DATE NOT NULL,
employee_hash STRING(100) COLLATE 'und:ci',
wh_id INTEGER,
missingtype_id STRING(40),
hours_cnt NUMERIC(9,5),
cancel_fg BIGNUMERIC(38) NOT NULL,
file_record_id BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_cal_dt DATE,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);