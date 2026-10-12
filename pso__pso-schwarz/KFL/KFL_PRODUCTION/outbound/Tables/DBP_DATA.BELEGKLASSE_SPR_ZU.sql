CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belegklasse_spr_zu (
spr_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
belegklasse_id STRING(5) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
belegklasse_bez STRING(40),
belegklasse_bez_kurz STRING(20),
belegklasse_bez_lang STRING(100),
td_update TIMESTAMP,
td_insert TIMESTAMP
);