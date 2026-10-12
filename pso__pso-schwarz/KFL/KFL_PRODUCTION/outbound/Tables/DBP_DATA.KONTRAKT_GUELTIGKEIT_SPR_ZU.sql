CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kontrakt_gueltigkeit_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kontrakt_gueltigkeit_id STRING(1) NOT NULL,
kontrakt_gueltigkeit_bez STRING(60),
td_update TIMESTAMP,
td_insert TIMESTAMP
);