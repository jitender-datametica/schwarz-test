CREATE OR REPLACE TABLE process_mining_production_etl.t_cmdb_hardware_product_model_l3_1 (
owner STRING(16777216),
u_last_data_review_by STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);