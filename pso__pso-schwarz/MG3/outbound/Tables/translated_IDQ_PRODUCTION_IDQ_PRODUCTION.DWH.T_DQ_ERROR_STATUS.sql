CREATE OR REPLACE TABLE idq_production_dwh.t_dq_error_status (
status_id INTEGER NOT NULL,
status_desc STRING(200),
PRIMARY KEY (status_id) NOT ENFORCED
);