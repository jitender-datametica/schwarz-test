CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_it_gremium (
it_gremium_id BIGNUMERIC(38,0) NOT NULL,
it_gremium_bez STRING(30) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);