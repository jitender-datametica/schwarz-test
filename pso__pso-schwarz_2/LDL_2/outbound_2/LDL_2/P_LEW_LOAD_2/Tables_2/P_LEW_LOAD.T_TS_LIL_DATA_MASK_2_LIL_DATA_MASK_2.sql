CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_lil_data_mask_2_lil_data_mask_2 (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
region_sid BIGNUMERIC(38),
period_sid BIGNUMERIC(38),
src_assort_parent_cat_cd STRING(100) COLLATE 'und:ci',
interface_name STRING(20) COLLATE 'und:ci',
mask_data_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);