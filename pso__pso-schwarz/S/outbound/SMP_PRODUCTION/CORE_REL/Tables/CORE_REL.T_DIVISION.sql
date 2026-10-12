CREATE OR REPLACE TABLE smp_production_core_rel.t_division (
division_id STRING(100) NOT NULL,
division_name STRING(100) NOT NULL,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);