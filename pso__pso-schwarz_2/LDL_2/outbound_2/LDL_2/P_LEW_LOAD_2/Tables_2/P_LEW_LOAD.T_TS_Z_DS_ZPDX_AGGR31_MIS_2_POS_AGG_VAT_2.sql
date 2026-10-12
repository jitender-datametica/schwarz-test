CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_zpdx_aggr31_mis_2_pos_agg_vat_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
aggr_nr BIGNUMERIC(38),
aggr_rec_nr BIGNUMERIC(38),
curr_sid BIGNUMERIC(38),
tax_type_cd STRING(20),
tax_val NUMERIC(18,5),
curr_cd STRING(20),
dwh_cal_dt DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);