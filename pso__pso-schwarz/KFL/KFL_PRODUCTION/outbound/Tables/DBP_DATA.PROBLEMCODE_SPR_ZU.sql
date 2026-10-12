CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.problemcode_spr_zu (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
problemcode_id STRING(7) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
problemcode_bez STRING(40),
problemcode_bez_kurz STRING(20),
problemcode_bez_lang STRING(100),
td_update TIMESTAMP,
td_insert TIMESTAMP
);