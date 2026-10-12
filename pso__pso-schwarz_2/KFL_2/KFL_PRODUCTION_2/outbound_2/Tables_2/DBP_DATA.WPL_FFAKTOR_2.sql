CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wpl_ffaktor_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
platzierungsstufe_id STRING(3) COLLATE 'und:ci' NOT NULL,
platzierungswg_id BIGNUMERIC(38,0) NOT NULL,
faktor NUMERIC(9,3) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);