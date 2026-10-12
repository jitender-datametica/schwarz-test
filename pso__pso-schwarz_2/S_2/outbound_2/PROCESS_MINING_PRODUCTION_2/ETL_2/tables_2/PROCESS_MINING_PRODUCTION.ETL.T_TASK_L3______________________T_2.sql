CREATE OR REPLACE TABLE process_mining_production_etl.t_task_l3______________________t_2 (
assigned_to STRING(16777216),
u_caller STRING(16777216),
closed_by STRING(16777216),
opened_by STRING(16777216),
u_current_obv STRING(16777216),
watch_list STRING(16777216),
u_updated_by STRING(16777216),
u_service_manager STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);