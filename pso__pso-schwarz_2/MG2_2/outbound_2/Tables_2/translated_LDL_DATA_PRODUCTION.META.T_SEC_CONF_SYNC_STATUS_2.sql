CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_sync_status_2 (
sync_status_cd STRING(20) NOT NULL OPTIONS(description='The status_2 of the synchronisation status_2 successful or error'),
sync_status_descr STRING(250) NOT NULL OPTIONS(description='The description of  the synchronisation status_2 '),
PRIMARY KEY (sync_status_cd) NOT ENFORCED
) OPTIONS(description='The status_2 of sync, if it is sucess or error is');