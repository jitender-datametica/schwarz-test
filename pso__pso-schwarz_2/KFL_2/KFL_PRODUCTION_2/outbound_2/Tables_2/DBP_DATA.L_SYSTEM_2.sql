CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_system_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
system_bez STRING(20) COLLATE 'und:ci' NOT NULL,
kl_system_bez STRING(10) COLLATE 'und:ci' NOT NULL,
kl_system_id STRING(2) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_rolle STRING(1) COLLATE 'und:ci' NOT NULL,
system_gruppe STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);