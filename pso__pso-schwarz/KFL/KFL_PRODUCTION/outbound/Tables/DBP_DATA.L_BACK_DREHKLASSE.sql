CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_back_drehklasse (
mandant_id BIGNUMERIC(38,0) NOT NULL,
back_drehklasse_id STRING(2) COLLATE 'und:ci' NOT NULL,
menge_min BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);