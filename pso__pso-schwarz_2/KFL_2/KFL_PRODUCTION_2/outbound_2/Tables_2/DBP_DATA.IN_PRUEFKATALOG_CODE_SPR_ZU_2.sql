CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_pruefkatalog_code_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
katalogart_id STRING(1) COLLATE 'und:ci' NOT NULL,
codegruppe_id STRING(10) COLLATE 'und:ci' NOT NULL,
pruefcode_id STRING(4) COLLATE 'und:ci' NOT NULL,
version_id STRING(7) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
qtxt_code STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);