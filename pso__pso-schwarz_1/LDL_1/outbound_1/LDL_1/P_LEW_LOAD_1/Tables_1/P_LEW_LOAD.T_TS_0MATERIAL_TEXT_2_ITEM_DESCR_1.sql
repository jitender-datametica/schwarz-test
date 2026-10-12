CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_0material_text_2_item_descr_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_sid BIGNUMERIC(38),
lang_sid BIGNUMERIC(38),
lang_cd STRING(20),
item_descr STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);