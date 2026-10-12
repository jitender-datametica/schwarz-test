CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_bericht_kat_zu_per (
teku_bericht_id BIGNUMERIC(38,0) NOT NULL,
teku_kategorie_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
teku_kategorie_note BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);