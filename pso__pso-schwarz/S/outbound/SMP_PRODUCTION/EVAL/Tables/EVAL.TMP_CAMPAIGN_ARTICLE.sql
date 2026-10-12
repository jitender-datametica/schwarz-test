CREATE OR REPLACE TABLE smp_production_eval.tmp_campaign_article (
division_id STRING(100),
country_id STRING(100),
division_country_ref INTEGER,
campaign_id STRING(100),
campaign_name STRING(500),
gtin_id STRING(100),
gtin_name STRING(100),
campaign_fg INTEGER,
level_1_supplier_fg INTEGER,
level_1_fg INTEGER,
level_2_supplier_fg INTEGER,
level_2_fg INTEGER,
level_3_supplier_fg INTEGER,
level_3_fg INTEGER
);