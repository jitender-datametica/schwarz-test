CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_process_mstr_lil_period_2_lil_period (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
period_sid BIGNUMERIC(38),
period_id BIGNUMERIC(38),
period_lvl BIGNUMERIC(38),
liam_avbl_fg BIGNUMERIC(38),
lift_avbl_fg BIGNUMERIC(38),
active_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);