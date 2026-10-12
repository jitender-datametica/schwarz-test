CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itembuyer_2_mdm_item_buyer_role_hist_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itembuyer_cbxitem_documentref STRING(250),
cbx_item_itembuyer_cbxitem_buyer_buyerrole STRING(250),
cbx_item_itembuyer_cbxitem_buyer_documentref STRING(250),
src_item_doc_ref STRING(40),
src_user_doc_ref STRING(200),
role_type_cd STRING(20) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);