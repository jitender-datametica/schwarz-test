CREATE TABLE IF NOT EXISTS kfl_nfmd_core.ts_msi_comments_inserts_1 (
year_id BIGNUMERIC(38,0) NOT NULL,
week_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktion_id STRING(255) NOT NULL,
sku_id BIGNUMERIC(38,0) NOT NULL,
created_at DATETIME NOT NULL,
user_id STRING(255) NOT NULL,
jf_comment STRING(255)
);