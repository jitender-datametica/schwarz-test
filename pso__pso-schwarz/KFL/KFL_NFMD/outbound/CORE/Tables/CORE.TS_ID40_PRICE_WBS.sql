CREATE TABLE IF NOT EXISTS kfl_nfmd_core.ts_id40_price_wbs (
year_id BIGNUMERIC(38,0),
week_id BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
aktion_id STRING(255),
sku_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
created_at DATETIME,
user_id STRING(255),
manual_markdown_price BIGNUMERIC(36,2)
);