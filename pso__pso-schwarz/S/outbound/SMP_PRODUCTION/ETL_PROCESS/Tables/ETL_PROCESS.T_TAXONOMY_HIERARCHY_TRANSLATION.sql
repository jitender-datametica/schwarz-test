CREATE OR REPLACE TABLE smp_production_etl_process.t_taxonomy_hierarchy_translation (
division_id STRING(100) NOT NULL,
language_id STRING(100) NOT NULL,
taxonomy_id STRING(100) NOT NULL,
level INTEGER,
taxonomy_name_translated STRING(500)
);