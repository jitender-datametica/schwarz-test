CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
inv_beleg_id INTEGER NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
zaehl_status_id STRING(1) COLLATE 'und:ci' NOT NULL,
diff_ausb_status_id STRING(1) COLLATE 'und:ci' NOT NULL,
dat_letzt_zaehl DATE,
dat_plan_zaehl DATE,
td_update TIMESTAMP,
td_insert TIMESTAMP
);