CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.load_log_kurs (
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
ok_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);