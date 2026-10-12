CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_buchungskreis_1 (
buchungskreis_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
kontenplan_id STRING(4) COLLATE 'und:ci',
sako_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);