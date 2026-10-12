CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lage (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lage_id BIGNUMERIC(38,0) NOT NULL,
lage_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);