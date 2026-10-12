CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_lc_prtcl_dat_dayend_context_map (
context_country_cd STRING(3) COLLATE 'und:ci' NOT NULL,
client_id INTEGER NOT NULL,
context_load_id INTEGER NOT NULL,
orig_store_nr INTEGER NOT NULL,
loc_sid INTEGER NOT NULL,
dwh_cal_dt DATE NOT NULL,
dat_dayend DATE NOT NULL,
created_ts DATETIME NOT NULL,
PRIMARY KEY (client_id, context_load_id, loc_sid, dwh_cal_dt, dat_dayend) NOT ENFORCED
);