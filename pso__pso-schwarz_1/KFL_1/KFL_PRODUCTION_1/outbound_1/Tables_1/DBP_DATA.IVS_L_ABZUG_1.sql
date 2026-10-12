CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_abzug_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
abzug_id BIGNUMERIC(38,0) NOT NULL,
abzug_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);