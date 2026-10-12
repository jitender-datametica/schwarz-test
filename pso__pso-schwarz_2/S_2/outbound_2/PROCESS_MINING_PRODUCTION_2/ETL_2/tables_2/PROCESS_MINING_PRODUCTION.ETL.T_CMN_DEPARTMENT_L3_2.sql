CREATE OR REPLACE TABLE process_mining_production_etl.t_cmn_department_l3_2 (
dept_head STRING(16777216),
primary_contact STRING(16777216),
u_assistants STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);