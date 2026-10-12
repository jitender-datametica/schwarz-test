CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_bedienkonzept_1 (
bedienkonzept_id BIGNUMERIC(38,0) NOT NULL,
bedienkonzept_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);