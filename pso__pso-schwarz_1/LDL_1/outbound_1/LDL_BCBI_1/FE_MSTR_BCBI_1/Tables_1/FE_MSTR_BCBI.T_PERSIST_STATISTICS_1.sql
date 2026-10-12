CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_persist_statistics_1 (
job_id INTEGER,
job STRING(255),
job_definition STRING(255),
status_1 STRING(255),
parent_job_id INTEGER,
start_time DATETIME,
end_time DATETIME,
duration STRING(255),
host STRING(500),
application STRING(255),
timestamp_load_bcbi TIMESTAMP
);