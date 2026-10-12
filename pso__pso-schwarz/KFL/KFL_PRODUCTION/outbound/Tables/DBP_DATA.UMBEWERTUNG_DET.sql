CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.umbewertung_det (
mandant_id BIGNUMERIC(38,0) NOT NULL,
pae_beleg_id INTEGER NOT NULL,
kj BIGNUMERIC(38,0) NOT NULL,
pae_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
bewertungskreis_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);