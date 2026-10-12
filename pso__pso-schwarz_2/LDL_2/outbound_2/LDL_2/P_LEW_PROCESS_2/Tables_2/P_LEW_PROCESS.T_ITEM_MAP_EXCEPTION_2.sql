CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_item_map_exception_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
orig_item_nr BIGNUMERIC(38,0) NOT NULL,
case_size BIGNUMERIC(38,0) NOT NULL,
dat_valid_from DATE NOT NULL,
item_sid BIGNUMERIC(38,0),
map_client_id BIGNUMERIC(38,0) NOT NULL,
map_orig_item_nr BIGNUMERIC(38,0) NOT NULL,
map_case_size BIGNUMERIC(38,0) NOT NULL,
map_dat_valid_from DATE NOT NULL,
map_item_sid BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id;