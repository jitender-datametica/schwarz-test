CREATE OR REPLACE TABLE smp_production_core_rel.t_store_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
division_country_ref INTEGER,
store_id STRING(100) NOT NULL,
store_nr INTEGER NOT NULL,
store_id_ref INTEGER NOT NULL,
store_name STRING(500) NOT NULL,
region_name STRING(500) NOT NULL,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);