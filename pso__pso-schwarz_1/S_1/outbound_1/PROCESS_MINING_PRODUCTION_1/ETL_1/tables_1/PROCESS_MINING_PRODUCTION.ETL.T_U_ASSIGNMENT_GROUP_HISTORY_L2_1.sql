CREATE OR REPLACE TABLE process_mining_production_etl.t_u_assignment_group_history_l2_1 (
sys_created_on DATETIME,
sys_mod_count BIGNUMERIC(38,0),
u_assigned_at DATETIME,
u_assignment_group STRING(16777216),
u_assignment_revoked_at DATETIME,
u_final_assignment BOOL,
u_order BIGNUMERIC(38,0),
u_sys_class_name STRING(16777216),
u_task STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);