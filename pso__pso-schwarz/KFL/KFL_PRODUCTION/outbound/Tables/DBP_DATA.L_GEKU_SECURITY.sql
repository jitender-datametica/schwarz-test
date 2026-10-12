CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_geku_security (
security_fg BIGNUMERIC(38,0) NOT NULL,
security_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);