CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.problemklasse_spr_zu_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
problemklasse_id STRING(10) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
problemklasse_bez STRING(40),
problemklasse_bez_kurz STRING(20),
problemklasse_bez_lang STRING(100),
td_update TIMESTAMP,
td_insert TIMESTAMP
);