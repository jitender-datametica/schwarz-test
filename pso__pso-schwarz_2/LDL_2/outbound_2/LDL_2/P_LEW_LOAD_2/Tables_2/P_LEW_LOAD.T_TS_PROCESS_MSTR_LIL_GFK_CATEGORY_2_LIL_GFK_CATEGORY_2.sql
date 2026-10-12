CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_process_mstr_lil_gfk_category_2_lil_gfk_category_2 (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
gfk_cat_sid BIGNUMERIC(38),
gfk_cat_id BIGNUMERIC(38),
gfk_cat_name_en STRING(100) COLLATE 'und:ci',
gfk_cat_name_de STRING(100) COLLATE 'und:ci',
gfk_cat_short_name STRING(100) COLLATE 'und:ci',
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