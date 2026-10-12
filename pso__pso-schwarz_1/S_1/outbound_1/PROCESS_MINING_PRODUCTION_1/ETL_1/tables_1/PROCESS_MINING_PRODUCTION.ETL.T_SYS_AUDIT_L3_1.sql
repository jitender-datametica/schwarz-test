CREATE OR REPLACE TABLE process_mining_production_etl.t_sys_audit_l3_1 (
sys_created_by STRING(16777216),
user STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_created_on DATETIME,
PRIMARY KEY (sys_id) NOT ENFORCED
);