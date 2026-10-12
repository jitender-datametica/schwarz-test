CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.woche_kj_kl_1 (
kjwo_kl BIGNUMERIC(38,0) NOT NULL,
kjwo_kl_dat_von DATE,
kjwo_kl_dat_bis DATE,
akt_kjwo_kl BIGNUMERIC(38,0),
akt_kjwo_kl_komplett BIGNUMERIC(38,0),
akt_kj BIGNUMERIC(38,0),
akt_kj_komplett BIGNUMERIC(38,0),
kjwo BIGNUMERIC(38,0),
akt_wo BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);