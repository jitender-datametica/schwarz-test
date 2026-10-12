CREATE OR REPLACE TABLE smp_production_core_rel.t_region_type_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
region_type_id STRING(100) NOT NULL,
region_type_name STRING(100),
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);