CREATE TABLE IF NOT EXISTS kfl_nfmd_core.ts_id40_final_submit_1 (
year_id BIGNUMERIC(38,0) NOT NULL,
week_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktion_id STRING(255) NOT NULL,
sku_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
created_at DATETIME NOT NULL,
user_id STRING(255) NOT NULL,
submitted_price BIGNUMERIC(36,2),
valid_from_date DATETIME,
latest_transfer_date DATETIME,
src_md_price_opt BIGNUMERIC(36,2)
);