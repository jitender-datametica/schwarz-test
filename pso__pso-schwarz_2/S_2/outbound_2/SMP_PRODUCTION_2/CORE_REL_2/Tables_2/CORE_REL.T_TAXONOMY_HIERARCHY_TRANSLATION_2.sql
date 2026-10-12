CREATE OR REPLACE TABLE smp_production_core_rel.t_taxonomy_hierarchy_translation_2 (
division_id STRING(100) NOT NULL,
language_id STRING(100) NOT NULL,
taxonomy_id STRING(100) NOT NULL,
level INTEGER,
taxonomy_name_translated STRING(500),
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);