CREATE OR REPLACE TABLE kfl_production_dbp_data.tp_objekt_merkmal (
mandant_id INTEGER NOT NULL,
tp_merkmal_id INTEGER NOT NULL,
tp_objekt_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
tp_merkmal_klasse_id INTEGER NOT NULL,
tp_merkmalwert STRING(255) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);