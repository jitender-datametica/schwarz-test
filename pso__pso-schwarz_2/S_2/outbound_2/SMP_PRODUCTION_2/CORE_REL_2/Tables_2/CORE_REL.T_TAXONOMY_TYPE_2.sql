CREATE OR REPLACE TABLE smp_production_core_rel.t_taxonomy_type_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
taxonomy_type_id STRING(100) NOT NULL,
taxonomy_type_name STRING(500) NOT NULL,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);