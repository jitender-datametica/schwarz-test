CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verfuegbarkeitsgruppe_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
verfuegbarkeitsgruppe_id STRING(4) NOT NULL,
verfuegbarkeitsgruppe_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);