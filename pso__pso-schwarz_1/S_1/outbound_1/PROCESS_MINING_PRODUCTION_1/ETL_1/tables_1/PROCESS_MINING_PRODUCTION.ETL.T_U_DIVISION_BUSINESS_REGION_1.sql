CREATE OR REPLACE TABLE process_mining_production_etl.t_u_division_business_region_1 (
u_countries STRING(16777216),
u_business_region STRING(16777216),
u_division STRING(16777216),
sys_class_name STRING(16777216),
sys_created_on DATETIME,
sys_mod_count BIGNUMERIC(38,0),
u_active BOOL,
u_handover_process_date DATETIME,
u_label STRING(16777216),
u_store_hotline_number STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);