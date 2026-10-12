CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lil_registry_files_2_lil_registry_files (
file_id BIGNUMERIC(38) NOT NULL,
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
interface_name STRING(100) COLLATE 'und:ci' NOT NULL,
data_provider STRING(100) COLLATE 'und:ci' NOT NULL,
delivery_cd STRING(100) COLLATE 'und:ci' NOT NULL,
checksum STRING(100) COLLATE 'und:ci' NOT NULL,
processing_ts DATETIME NOT NULL,
command STRING(20) COLLATE 'und:ci',
note STRING(300) COLLATE 'und:ci',
status STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);