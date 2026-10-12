CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemuniquestyle_2_mdm_item_set_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemuniquestyle_cbxitem_documentref STRING(250),
cbx_item_itemuniquestyle_cbxitem_uniquestyle_itemstyleuniqueids STRING(2000),
src_item_doc_ref STRING(20) COLLATE 'und:ci',
src_style_uniqids_cd STRING(2000) COLLATE 'und:ci',
set_content_qty BIGNUMERIC(38),
set_multipack_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);