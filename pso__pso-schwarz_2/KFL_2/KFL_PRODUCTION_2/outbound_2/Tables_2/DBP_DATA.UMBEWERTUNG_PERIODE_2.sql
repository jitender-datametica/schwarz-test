CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.umbewertung_periode_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
pae_beleg_id INTEGER NOT NULL,
kj BIGNUMERIC(38,0) NOT NULL,
pae_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
gjmo BIGNUMERIC(38,0) NOT NULL,
periodenart_id STRING(2) COLLATE 'und:ci' NOT NULL,
dat_buch DATE NOT NULL,
menge_bestand_bme_alt NUMERIC(18,3) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);