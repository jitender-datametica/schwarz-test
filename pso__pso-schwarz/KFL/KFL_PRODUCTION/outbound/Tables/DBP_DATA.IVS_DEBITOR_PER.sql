CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_debitor_per (
debitor_id INTEGER NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
debitor_status_id STRING(3) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
konzern_id INTEGER,
konzessionaer_id STRING(20) COLLATE 'und:ci',
ivs_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);