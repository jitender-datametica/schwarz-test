CREATE TABLE IF NOT EXISTS szd_etl_process.it4you_int_incident_problem_u_assignment_group_history_1 (
sys_created_on TIMESTAMP,
sys_id STRING(500),
sys_mod_count BIGNUMERIC(38,0),
sys_updated_on TIMESTAMP,
u_assigned_at TIMESTAMP,
u_assignment_group STRING(500),
u_assignment_revoked_at TIMESTAMP,
u_final_assignment STRING(500),
u_order BIGNUMERIC(38,0),
u_sys_class_name STRING(500),
u_task STRING(500),
dwh_src_file_name STRING(500),
dwh_extract_tmsp TIMESTAMP
);