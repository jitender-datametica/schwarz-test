CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nielsen_market_cluster_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
nielsen_market_cluster_id BIGNUMERIC(38,0) NOT NULL,
nielsen_market_cluster_bez STRING(255) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);