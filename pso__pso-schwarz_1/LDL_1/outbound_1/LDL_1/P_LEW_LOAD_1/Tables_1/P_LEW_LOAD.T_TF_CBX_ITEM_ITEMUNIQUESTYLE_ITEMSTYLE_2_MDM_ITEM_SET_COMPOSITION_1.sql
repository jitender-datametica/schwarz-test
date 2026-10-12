CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemuniquestyle_itemstyle_2_mdm_item_set_composition_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemuniquestyle_itemstyle_cbxitem_documentref STRING(250),
cbx_item_itemuniquestyle_itemstyle_cbxitem_uniquestyle_itemstyleuniqueids STRING(2000),
cbx_item_itemuniquestyle_itemstyle_cbxitem_uniquestyle_itemstyle_uniqueid STRING(250),
src_item_doc_ref STRING(40),
src_style_uniqids_cd STRING(2000),
src_style_uniq_id STRING(400),
style_qty BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);