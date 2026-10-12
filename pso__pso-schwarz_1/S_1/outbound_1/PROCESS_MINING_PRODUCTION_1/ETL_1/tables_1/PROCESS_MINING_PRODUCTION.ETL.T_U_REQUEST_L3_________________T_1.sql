CREATE OR REPLACE TABLE process_mining_production_etl.t_u_request_l3_________________t_1 (
additional_assignee_list STRING(16777216),
assigned_to STRING(16777216),
closed_by STRING(16777216),
opened_by STRING(16777216),
u_assigned_to_history STRING(16777216),
u_caller STRING(16777216),
u_caller_country STRING(16777216),
u_completed_by STRING(16777216),
u_current_obv STRING(16777216),
u_personal_data STRING(16777216),
u_service_manager STRING(16777216),
u_update_user_history STRING(16777216),
u_updated_by STRING(16777216),
work_notes_list STRING(16777216),
sys_id STRING(16777216) NOT NULL,
sys_updated_on DATETIME NOT NULL,
PRIMARY KEY (sys_id, sys_updated_on) NOT ENFORCED
);