CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_branche (
mandant_id BIGNUMERIC(38,0) NOT NULL,
branche_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
branche_bez STRING(40) DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);