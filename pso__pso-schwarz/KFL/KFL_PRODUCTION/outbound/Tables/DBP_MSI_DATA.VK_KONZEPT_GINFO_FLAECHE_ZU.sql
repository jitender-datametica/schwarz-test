CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vk_konzept_ginfo_flaeche_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
vk_konzept_id BIGNUMERIC(38,0) NOT NULL,
ginfo_flaeche_id STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);