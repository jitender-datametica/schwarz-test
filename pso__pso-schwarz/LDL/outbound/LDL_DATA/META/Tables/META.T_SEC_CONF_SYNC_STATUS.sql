CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_conf_sync_status (
sync_status_cd STRING(20) NOT NULL OPTIONS(description='The status of the synchronisation status successful or error'),
sync_status_descr STRING(250) NOT NULL OPTIONS(description='The description of  the synchronisation status '),
PRIMARY KEY (sync_status_cd) NOT ENFORCED
) OPTIONS(description='The status of sync, if it is sucess or error is');