CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0salesorg_text_2_sales_org_descr_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
salesorg_text_key1 STRING(120),
salesorg_text_langu STRING(4),
src_vkorg STRING(40),
lang_cd STRING(20),
sales_org_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);