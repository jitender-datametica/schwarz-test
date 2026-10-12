CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kl_owg_nielsen (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kl_owg_id BIGNUMERIC(38,0) NOT NULL,
kl_wg_id BIGNUMERIC(38,0),
kl_owg_bez STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);