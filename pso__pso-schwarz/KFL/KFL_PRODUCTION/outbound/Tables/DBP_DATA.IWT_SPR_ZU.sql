CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.iwt_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
iwt_id STRING(1) NOT NULL,
iwt_bez STRING(60),
td_update TIMESTAMP,
td_insert TIMESTAMP
);