CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vk_konzept_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
vk_konzept_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
vk_konzept_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);