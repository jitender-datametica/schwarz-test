CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_item_map_key_oin_wh_hist_2 (
client_id BIGNUMERIC(38,0),
src_orig_item_nr STRING(20) NOT NULL,
src_orig_wh_nr BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);