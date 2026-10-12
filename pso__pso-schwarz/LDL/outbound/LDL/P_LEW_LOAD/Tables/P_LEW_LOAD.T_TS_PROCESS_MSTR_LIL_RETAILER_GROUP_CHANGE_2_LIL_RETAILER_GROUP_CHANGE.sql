CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_process_mstr_lil_retailer_group_change_2_lil_retailer_group_change (
record_id STRING(1000) COLLATE 'und:ci',
retailer_group_change_id BIGNUMERIC(38),
src_retailer_grp_cd STRING(100),
src_retailer_chld_cd STRING(100),
src_retailer_chg_cd STRING(100),
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