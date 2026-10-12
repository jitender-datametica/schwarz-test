CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.woche_gj_kl_1 (
gjwo_kl BIGNUMERIC(38,0) NOT NULL,
gjwo_kl_dat_von DATE,
gjwo_kl_dat_bis DATE,
akt_gjwo_kl BIGNUMERIC(38,0),
akt_gjwo_kl_komplett BIGNUMERIC(38,0),
akt_gj BIGNUMERIC(38,0),
akt_gj_komplett BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);