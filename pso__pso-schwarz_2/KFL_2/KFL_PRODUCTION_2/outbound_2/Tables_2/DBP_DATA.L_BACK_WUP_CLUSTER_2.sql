CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_back_wup_cluster_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_cluster_id BIGNUMERIC(38,0) NOT NULL,
wup_cluster_bez STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);