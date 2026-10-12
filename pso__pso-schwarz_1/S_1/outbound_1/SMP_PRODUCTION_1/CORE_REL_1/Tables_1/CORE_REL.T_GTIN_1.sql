CREATE OR REPLACE TABLE smp_production_core_rel.t_gtin_1 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
gtin_id STRING(100) NOT NULL,
gtin_name STRING(500) NOT NULL,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER,
article_id_ref STRING(100),
brand_1 STRING(100),
brand_adjusted STRING(100)
);