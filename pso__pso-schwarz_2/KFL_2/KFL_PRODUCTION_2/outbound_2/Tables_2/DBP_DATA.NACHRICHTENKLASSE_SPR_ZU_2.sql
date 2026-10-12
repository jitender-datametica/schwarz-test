CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nachrichtenklasse_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
nachrichtenklasse_id STRING(1) NOT NULL,
nachrichtenklasse_bez STRING(60),
td_update TIMESTAMP,
td_insert TIMESTAMP
);