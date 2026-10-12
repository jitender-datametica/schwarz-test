CREATE OR REPLACE TABLE smp_production_core_rel.t_map_store_container_region_1 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
container_id STRING(100) NOT NULL,
region_id STRING(100) NOT NULL,
region_type_id STRING(100) NOT NULL,
store_id INTEGER NOT NULL,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);