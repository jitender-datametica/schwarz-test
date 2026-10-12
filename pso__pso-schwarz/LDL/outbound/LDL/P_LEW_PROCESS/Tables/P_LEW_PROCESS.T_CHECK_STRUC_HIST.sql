CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_check_struc_hist (
db_name STRING(200) NOT NULL,
tbl_name STRING(200) NOT NULL,
col_name STRING(200) NOT NULL,
col_type STRING(200),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_real_start DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME,
PRIMARY KEY (db_name, tbl_name, col_name, dwh_valid_from) NOT ENFORCED
);