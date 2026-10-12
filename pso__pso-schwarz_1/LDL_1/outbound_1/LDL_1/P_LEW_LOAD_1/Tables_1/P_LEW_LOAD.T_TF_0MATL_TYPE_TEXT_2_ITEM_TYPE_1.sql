CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0matl_type_text_2_item_type_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
matl_type_text_key1 STRING(120),
matl_type_text_langu STRING(4),
src_mtart STRING(20),
item_type_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);