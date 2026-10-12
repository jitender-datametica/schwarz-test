CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tp_objekt_merkmal (
mandant_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_id BIGNUMERIC(38,0) NOT NULL,
tp_objekt_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
tp_merkmal_klasse_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmalwert STRING(255) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);