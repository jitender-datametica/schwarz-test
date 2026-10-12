CREATE OR REPLACE TABLE smp_production_core_rel.t_taxonomy_gtin (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
taxonomy_id STRING(100) NOT NULL,
taxonomy_type_id STRING(100) NOT NULL,
level INTEGER,
gtin_id STRING(100) NOT NULL,
taxonomy_path STRING(100),
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);