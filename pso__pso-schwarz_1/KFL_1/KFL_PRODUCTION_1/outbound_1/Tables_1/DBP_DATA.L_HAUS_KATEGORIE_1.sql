CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_haus_kategorie_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
haus_kategorie_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);