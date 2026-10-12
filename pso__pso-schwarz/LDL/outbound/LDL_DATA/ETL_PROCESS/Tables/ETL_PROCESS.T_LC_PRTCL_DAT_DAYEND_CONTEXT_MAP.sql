CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_lc_prtcl_dat_dayend_context_map (
context_country_cd STRING(3) COLLATE 'und:ci' NOT NULL,
client_id BIGNUMERIC(38) NOT NULL,
context_load_id BIGNUMERIC(38) NOT NULL,
orig_store_nr BIGNUMERIC(38) NOT NULL,
loc_sid BIGNUMERIC(38) NOT NULL,
dwh_cal_dt DATE NOT NULL,
dat_dayend DATE NOT NULL,
created_ts DATETIME NOT NULL,
PRIMARY KEY (client_id, context_load_id, loc_sid, dwh_cal_dt, dat_dayend) NOT ENFORCED
);