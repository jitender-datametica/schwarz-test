CREATE OR REPLACE TABLE process_mining_production_etl.t_u_division_l2_1 (
sys_created_on DATETIME,
sys_mod_count BIGNUMERIC(38,0),
u_active BOOL,
u_code STRING(16777216),
u_logo STRING(16777216),
u_name STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);