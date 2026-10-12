CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nachrichtenstatus_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
nachrichtenstatus_id STRING(1) NOT NULL,
nachrichtenstatus_bez STRING(60),
td_update TIMESTAMP,
td_insert TIMESTAMP
);