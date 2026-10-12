CREATE OR REPLACE TABLE smp_production_eval.cdp_campaign_gtin_halo_2 (
division_id STRING(100),
country_id STRING(100),
division_country_ref INTEGER,
campaign_id STRING(100),
gtin_id STRING(100),
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER,
campaign_gtin_regular_unit_price NUMERIC(29,2)
);