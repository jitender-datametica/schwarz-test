CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_relateditem_2_mdm_item_related_item_hist_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_relateditem_cbxitem_documentref STRING(250),
cbx_item_relateditem_cbxitem_relateditem_relateditemtype STRING(250),
src_item_doc_ref STRING(40),
item_rel_type_cd STRING(20) COLLATE 'und:ci',
src_item_doc_ref_related STRING(40),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);