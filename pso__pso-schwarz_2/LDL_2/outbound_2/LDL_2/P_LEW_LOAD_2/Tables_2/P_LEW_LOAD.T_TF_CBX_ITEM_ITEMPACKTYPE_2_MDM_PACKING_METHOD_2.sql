CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itempacktype_2_mdm_packing_method_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itempacktype_cbxitem_itemassortment_code STRING(250),
cbx_item_itempacktype_cbxitem_itemassortment_name STRING(250),
cbx_item_itempacktype_cbxitem_itempacktype_code STRING(250),
cbx_item_itempacktype_cbxitem_itempacktype_name STRING(250),
src_assortment_cd STRING(20) COLLATE 'und:ci',
src_pack_type_cd STRING(20) COLLATE 'und:ci',
pack_assort_type STRING(100) COLLATE 'und:ci',
pack_method STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);