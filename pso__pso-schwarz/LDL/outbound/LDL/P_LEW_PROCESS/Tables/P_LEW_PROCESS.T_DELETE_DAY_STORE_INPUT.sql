CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_delete_day_store_input (
client_id BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE NOT NULL,
delete_area STRING(3) COLLATE 'und:ci' NOT NULL,
user_input STRING(200) COLLATE 'und:ci' NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);