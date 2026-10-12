CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_debitor_immo_objekt_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
immo_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
debitor_id INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);