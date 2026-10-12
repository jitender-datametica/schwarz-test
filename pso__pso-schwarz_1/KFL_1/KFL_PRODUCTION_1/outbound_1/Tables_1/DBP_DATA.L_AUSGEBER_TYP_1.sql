CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ausgeber_typ_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ausgeber_typ_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);