CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_it_projektart (
it_projektart_id BIGNUMERIC(38,0) NOT NULL,
it_projektart_bez STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);