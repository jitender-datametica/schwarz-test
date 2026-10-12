CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemuniquestyle_2_mdm_item_set_hist_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemuniquestyle_cbxitem_documentref STRING(250),
cbx_item_itemuniquestyle_cbxitem_uniquestyle_itemstyleuniqueids STRING(2000),
src_item_doc_ref STRING(40),
src_style_uniqids_cd STRING(2000),
style_names STRING(4000) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);