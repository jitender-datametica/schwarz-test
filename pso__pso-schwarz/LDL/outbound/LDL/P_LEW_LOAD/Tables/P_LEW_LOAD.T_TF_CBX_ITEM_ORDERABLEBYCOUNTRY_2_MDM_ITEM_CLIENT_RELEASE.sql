CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_orderablebycountry_2_mdm_item_client_release (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_orderablebycountry_cbxitem_documentref STRING(250),
cbx_item_orderablebycountry_cbxitem_orderablebycountry_country STRING(250),
src_item_doc_ref STRING(40),
client_id_release BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);