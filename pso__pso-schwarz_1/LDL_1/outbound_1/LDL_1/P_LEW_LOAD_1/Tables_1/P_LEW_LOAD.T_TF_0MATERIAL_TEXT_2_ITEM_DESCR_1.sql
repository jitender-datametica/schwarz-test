CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0material_text_2_item_descr_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
material_text_matnr STRING(36),
material_text_spras STRING(4),
src_matnr STRING(40),
lang_cd STRING(20),
item_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);