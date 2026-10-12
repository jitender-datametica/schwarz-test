CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.sortiment_art (
mandant_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
gtin_id STRING(120) COLLATE 'und:ci',
status STRING(4) COLLATE 'und:ci',
kjwo_update BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);