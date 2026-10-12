CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.l_kmr_security_filter (
sf_id BIGNUMERIC(38,0) NOT NULL,
sf_bez STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);