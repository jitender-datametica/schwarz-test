CREATE OR REPLACE TABLE smp_production_etl_process.t_map_ldl_store_container_region (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
smp_region_id STRING(100) NOT NULL,
smp_region_name STRING(500) NOT NULL,
smp_container_id STRING(100) NOT NULL,
smp_container_name STRING(500) NOT NULL,
store_id STRING(100) NOT NULL,
store_name STRING(500) NOT NULL,
wh_id STRING(100) NOT NULL,
wh_name STRING(500) NOT NULL,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);