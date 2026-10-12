CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_log_type (
log_type_cd STRING(20) NOT NULL OPTIONS(description='The type of the log type like information, debug or error'),
log_type_descr STRING(250) NOT NULL OPTIONS(description='The log type descripton'),
PRIMARY KEY (log_type_cd) NOT ENFORCED
) OPTIONS(description='The status of sync, if it is sucess or error is');