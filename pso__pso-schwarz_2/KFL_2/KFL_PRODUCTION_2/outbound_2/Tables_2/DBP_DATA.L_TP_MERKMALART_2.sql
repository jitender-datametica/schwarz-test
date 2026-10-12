CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tp_merkmalart_2 (
tp_merkmalart_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_klasse_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmalwert_id STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);