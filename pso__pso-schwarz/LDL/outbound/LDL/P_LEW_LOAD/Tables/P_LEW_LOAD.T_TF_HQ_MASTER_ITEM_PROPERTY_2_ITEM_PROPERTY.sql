CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_hq_master_item_property_2_item_property (
client_id BIGNUMERIC(38),
lidl_country STRING(40) COLLATE 'und:ci',
hq_master_item_property_src_item_property_id BIGNUMERIC(38),
src_item_property_id BIGNUMERIC(38),
src_atwrt STRING(50) COLLATE 'und:ci',
item_property_cd STRING(100) COLLATE 'und:ci',
item_property_int_name STRING(100) COLLATE 'und:ci',
item_property_local_name STRING(100) COLLATE 'und:ci',
item_property_descr STRING(1000) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000) COLLATE 'und:ci'
);