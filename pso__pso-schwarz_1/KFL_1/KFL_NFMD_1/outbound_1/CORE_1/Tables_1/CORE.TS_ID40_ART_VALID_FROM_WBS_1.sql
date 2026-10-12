CREATE TABLE IF NOT EXISTS kfl_nfmd_core.ts_id40_art_valid_from_wbs_1 (
year_id BIGNUMERIC(38,0) NOT NULL,
week_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktion_id STRING(255) NOT NULL,
sku_id BIGNUMERIC(38,0) NOT NULL,
created_at DATETIME NOT NULL,
user_id STRING(255) NOT NULL,
manual_markdown_date STRING(255)
);