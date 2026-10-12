CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_city_group_backup_20230719_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
city_group_sid BIGNUMERIC(38,0) NOT NULL,
src_city_group_id STRING(20) COLLATE 'und:ci' NOT NULL,
city_group_name STRING(100) COLLATE 'und:ci' NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id;