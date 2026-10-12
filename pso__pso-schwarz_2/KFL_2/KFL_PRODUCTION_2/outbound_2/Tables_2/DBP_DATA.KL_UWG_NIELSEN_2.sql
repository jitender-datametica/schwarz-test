CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kl_uwg_nielsen_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kl_uwg_id BIGNUMERIC(38,0) NOT NULL,
kl_owg_id BIGNUMERIC(38,0),
kl_uwg_bez STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);