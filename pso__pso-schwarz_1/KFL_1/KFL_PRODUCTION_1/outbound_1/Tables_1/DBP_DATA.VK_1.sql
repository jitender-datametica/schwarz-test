CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vk_1 (
vk_id BIGNUMERIC(38,0) NOT NULL,
vk_bez STRING(40) COLLATE 'und:ci',
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);