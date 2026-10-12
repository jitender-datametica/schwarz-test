CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemtype_2_ref_mdm_item_class_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemtype_cbxitem_itemtype_code STRING(250),
cbx_item_itemtype_cbxitem_itemtype_name STRING(250),
cbx_item_itemtype_cbxitem_itemtype_description STRING(250),
item_class_cd STRING(20) COLLATE 'und:ci',
item_class STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);