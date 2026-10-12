CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_registry_files_2 (
file_id BIGNUMERIC(38,0) NOT NULL,
file_name STRING(800) NOT NULL,
interface_name STRING(800) NOT NULL,
data_provider STRING(800) NOT NULL,
delivery_cd STRING(800) NOT NULL,
checksum STRING(800) NOT NULL,
processing_ts TIMESTAMP NOT NULL,
command STRING(160),
note STRING(2400),
status_2 STRING(800),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);