CREATE OR REPLACE TABLE smp_production_core_rel.t_region_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
region_id STRING(100) NOT NULL,
region_name STRING(100),
region_type_id STRING(100) NOT NULL,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);