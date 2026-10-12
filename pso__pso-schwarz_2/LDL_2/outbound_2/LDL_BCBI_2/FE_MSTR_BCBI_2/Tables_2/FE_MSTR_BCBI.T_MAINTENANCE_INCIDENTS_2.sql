CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_maintenance_incidents_2 (
id BIGNUMERIC(38,0),
info_type STRING(16777216),
subject STRING(16777216),
current_status STRING(16777216),
affected_countries STRING(16777216),
affected_system STRING(16777216),
affected_day DATE,
created_on DATE,
changed_on DATE,
affected_kpi STRING(16777216),
solution STRING(16777216),
problem_number STRING(16777216),
t_vta STRING(16777216),
topic STRING(16777216),
timestamp_load_bcbi TIMESTAMP
);