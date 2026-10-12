CREATE OR REPLACE TABLE kfl_production_dbp_data.nielsen_market_2 (
mandant_id INTEGER NOT NULL,
nielsen_market_id INTEGER NOT NULL,
nielsen_market_tag STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
nielsen_market_bez STRING(255) COLLATE 'und:ci',
nielsen_market_cluster_id INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);