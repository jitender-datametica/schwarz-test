CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_core_lil_gfk_category_descr_2_lil_gfk_category_descr_1 (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
gfk_cat_sid BIGNUMERIC(38),
lang_cd STRING(2) COLLATE 'und:ci',
gfk_cat_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);