CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.platzierungsstufe_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
platzierungsstufe_id STRING(3) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
platzierungsstufe_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);