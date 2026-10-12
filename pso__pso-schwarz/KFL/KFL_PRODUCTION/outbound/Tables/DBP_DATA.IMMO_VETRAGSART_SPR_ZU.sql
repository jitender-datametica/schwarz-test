CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_vetragsart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
vertragsart_id BIGNUMERIC(38,0) NOT NULL,
vertragsart_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);