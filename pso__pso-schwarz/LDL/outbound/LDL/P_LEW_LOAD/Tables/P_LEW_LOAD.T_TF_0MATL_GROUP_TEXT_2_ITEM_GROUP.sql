CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0matl_group_text_2_item_group (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
matl_group_text_key1 STRING(120),
src_matkl STRING(20),
src_wawi_cd STRING(20),
item_grp_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);