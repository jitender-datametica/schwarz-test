CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_platzierungsstufe_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
platzierungsstufe_id STRING(3) COLLATE 'und:ci' NOT NULL,
sk_id_apollo STRING(4) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);