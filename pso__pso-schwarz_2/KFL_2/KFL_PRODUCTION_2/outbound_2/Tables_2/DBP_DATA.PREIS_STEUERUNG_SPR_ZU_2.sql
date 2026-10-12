CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.preis_steuerung_spr_zu_2 (
preis_steuer_kz STRING(1) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
preis_steuerung_bez STRING(100) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);