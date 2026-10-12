CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.umbewertung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
pae_beleg_id INTEGER NOT NULL,
kj BIGNUMERIC(38,0) NOT NULL,
dat_beleg DATE NOT NULL,
dat_erfasst DATE NOT NULL,
zeit_erfasst BIGNUMERIC(38,0) NOT NULL,
beleg_user_name STRING(20) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);