CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zpdx_aggr31_mis_2_pos_agg_vat (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zpdx_aggr31_mis_aggr_no STRING(11),
z_ds_zpdx_aggr31_mis_rec_id STRING(11),
z_ds_zpdx_aggr31_mis_taxtypecode STRING(4),
aggr_nr BIGNUMERIC(38),
aggr_rec_nr BIGNUMERIC(38),
src_waers STRING(40),
tax_type_cd STRING(20),
tax_val NUMERIC(18,5),
curr_cd STRING(20),
dwh_cal_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);