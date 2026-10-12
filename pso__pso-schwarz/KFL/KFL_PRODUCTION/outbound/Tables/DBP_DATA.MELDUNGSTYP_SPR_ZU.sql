CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.meldungstyp_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
meldungstyp_id STRING(1) NOT NULL,
meldungstyp_bez STRING(60),
td_update TIMESTAMP,
td_insert TIMESTAMP
);