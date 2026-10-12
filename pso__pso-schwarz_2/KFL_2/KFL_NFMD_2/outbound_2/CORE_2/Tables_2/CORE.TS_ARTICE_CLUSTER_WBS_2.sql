CREATE TABLE IF NOT EXISTS kfl_nfmd_core.ts_artice_cluster_wbs_2 (
year_id BIGNUMERIC(38,0) NOT NULL,
week_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktion_id STRING(255) NOT NULL,
sku_id STRING(255) NOT NULL,
created_at DATETIME NOT NULL,
user_id STRING(255) NOT NULL,
article_cluster_id BIGNUMERIC(38,0) NOT NULL
);