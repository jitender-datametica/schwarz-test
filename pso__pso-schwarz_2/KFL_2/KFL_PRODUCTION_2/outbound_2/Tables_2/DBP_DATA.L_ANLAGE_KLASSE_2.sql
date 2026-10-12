CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_anlage_klasse_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
anlage_klasse_id STRING(10) COLLATE 'und:ci' NOT NULL,
gesperrt_fg BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);