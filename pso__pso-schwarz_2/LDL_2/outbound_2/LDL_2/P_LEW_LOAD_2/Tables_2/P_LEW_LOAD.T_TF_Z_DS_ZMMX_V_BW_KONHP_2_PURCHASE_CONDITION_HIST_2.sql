CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zmmx_v_bw_konhp_2_purchase_condition_hist_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zmmx_v_bw_konhp_knumh STRING(20),
src_knumh STRING(40),
src_waers STRING(40),
condition_pos_nr BIGNUMERIC(38),
curr_cd STRING(20),
condition_val NUMERIC(18,5),
condition_pct_val NUMERIC(18,5),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);