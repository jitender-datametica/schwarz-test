CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_einsatz_2 (
teku_einsatz_id BIGNUMERIC(38,0) NOT NULL,
teku_tour_id BIGNUMERIC(38,0) NOT NULL,
testkunde_id BIGNUMERIC(38,0) NOT NULL,
dat_soll DATETIME NOT NULL,
dat_korr DATETIME,
dat_ist DATETIME,
storno_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);