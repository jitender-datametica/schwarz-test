CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_mis_items_2_item_missing_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
item_missing_id NUMERIC(20,0),
src_orig_item_nr STRING(40),
src_dat_valid_from DATE,
src_case_size STRING(40),
src_orig_wh_nr INTEGER,
storage_loc_cd STRING(20),
dwh_cal_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);