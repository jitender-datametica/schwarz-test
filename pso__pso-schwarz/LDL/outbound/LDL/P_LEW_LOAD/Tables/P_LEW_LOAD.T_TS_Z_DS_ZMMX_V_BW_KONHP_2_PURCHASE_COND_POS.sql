CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_zmmx_v_bw_konhp_2_purchase_cond_pos (
record_id INTEGER,
client_id BIGNUMERIC(38),
pur_cond_sid BIGNUMERIC(38),
src_kopos BIGNUMERIC(38),
curr_sid BIGNUMERIC(38),
curr_cd STRING(20),
condition NUMERIC(18,5),
deleted_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);