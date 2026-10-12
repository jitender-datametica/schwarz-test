CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_lil_assort_category_2_lil_assort_category_1 (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
assort_cat_sid BIGNUMERIC(38),
src_assort_parent_cat_cd STRING(100),
src_assort_cat_cd STRING(300),
assort_parent_cat_name STRING(100) COLLATE 'und:ci',
assort_cat_name STRING(300) COLLATE 'und:ci',
assort_cat_level BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);