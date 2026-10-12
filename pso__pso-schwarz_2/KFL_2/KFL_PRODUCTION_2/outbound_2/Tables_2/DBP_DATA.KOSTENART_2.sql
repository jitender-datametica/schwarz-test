CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kostenart_2 (
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
kontenplan_id STRING(4) COLLATE 'und:ci',
kostenart_altnv_id STRING(10) COLLATE 'und:ci',
kostenart_grp_id STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);