CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.versandstelle_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
versandstelle_id STRING(4) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
versandstelle_bez STRING(30) DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);