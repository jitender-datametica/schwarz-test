CREATE OR REPLACE TABLE process_mining_production_etl.t_sys_user_l2 (
u_siam_deactivation_date DATETIME,
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);