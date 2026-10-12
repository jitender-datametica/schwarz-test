CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ma_hierarchie_ebene (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ma_hierarchie_ebene_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);