CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.baustein_art_zu_per_msi (
baustein_id INTEGER NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);