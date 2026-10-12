CREATE TABLE IF NOT EXISTS szd_etl_process.t_cache_container_1 (
system_id BIGNUMERIC(38,0),
export_state_p1 STRING(50),
export_date_p1 DATE,
export_state_p2 STRING(50),
export_date_p2 DATE,
export_state_p3 STRING(50),
export_date_p3 DATE,
export_state_p4 STRING(50),
export_date_p4 DATE,
dwh_src_file_name STRING(500),
dwh_src_1_tmsp TIMESTAMP,
valid_from TIMESTAMP,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED IN THE DATA WAREHOUSE.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED OR LAST UPDATED.'),
valid_to TIMESTAMP
);