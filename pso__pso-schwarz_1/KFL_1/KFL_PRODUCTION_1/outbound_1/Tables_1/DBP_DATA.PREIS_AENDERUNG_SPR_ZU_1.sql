CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.preis_aenderung_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
preis_aend_grund_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
preis_aend_grund_bez STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);