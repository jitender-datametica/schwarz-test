CREATE OR REPLACE TABLE smp_production_core_rel.t_country_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
division_country_ref INTEGER NOT NULL,
country_name STRING(100),
star_active_fg INTEGER,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER,
timezone STRING(100)
);