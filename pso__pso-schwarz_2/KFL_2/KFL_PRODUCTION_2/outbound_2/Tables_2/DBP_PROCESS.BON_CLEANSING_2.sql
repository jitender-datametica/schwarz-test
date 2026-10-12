CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.bon_cleansing_2 (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
bon_id STRING(25) COLLATE 'und:ci',
xml_name STRING(255) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);