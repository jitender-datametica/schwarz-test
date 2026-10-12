CREATE OR REPLACE TABLE smp_production_core_rel.t_supplier_gtin_1 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
supplier_id INTEGER NOT NULL,
supplier_id_ref INTEGER NOT NULL,
gtin_id STRING(100) NOT NULL,
source_system_id STRING(100),
create_tmsp DATETIME,
load_id INTEGER
);