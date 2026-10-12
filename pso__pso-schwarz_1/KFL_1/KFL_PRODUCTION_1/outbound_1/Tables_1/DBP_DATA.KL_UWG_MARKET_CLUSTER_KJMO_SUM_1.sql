CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kl_uwg_market_cluster_kjmo_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kl_uwg_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
nielsen_market_cluster_id BIGNUMERIC(38,0) NOT NULL,
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL,
anz_artikel BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
ek_mep NUMERIC(18,4) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);