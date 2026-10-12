CREATE OR REPLACE TABLE process_mining_production_etl.t_u_assignment_group_history_l3 (
u_assigned_by STRING(16777216),
u_assignment_revoked_by STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);