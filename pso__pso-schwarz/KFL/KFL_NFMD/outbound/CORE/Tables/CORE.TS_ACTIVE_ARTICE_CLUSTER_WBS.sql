CREATE TABLE IF NOT EXISTS kfl_nfmd_core.ts_active_artice_cluster_wbs (
created_at DATETIME NOT NULL,
user_id STRING(255) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
article_cluster_id BIGNUMERIC(38,0)
);