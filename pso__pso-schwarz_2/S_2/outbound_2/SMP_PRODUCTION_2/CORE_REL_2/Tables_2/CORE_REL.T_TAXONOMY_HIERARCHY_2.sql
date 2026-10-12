CREATE OR REPLACE TABLE smp_production_core_rel.t_taxonomy_hierarchy_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
taxonomy_id STRING(100) NOT NULL,
taxonomy_type_id STRING(100) NOT NULL,
taxonomy_name STRING(500),
taxonomy_parent_id STRING(100),
level INTEGER,
level_bez STRING(100),
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);