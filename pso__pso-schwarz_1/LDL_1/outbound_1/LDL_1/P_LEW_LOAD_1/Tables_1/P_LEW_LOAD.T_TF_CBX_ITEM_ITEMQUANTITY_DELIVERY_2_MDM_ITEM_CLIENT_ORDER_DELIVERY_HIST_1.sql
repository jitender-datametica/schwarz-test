CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemquantity_delivery_2_mdm_item_client_order_delivery_hist_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemquantity_delivery_cbxitem_documentref STRING(250),
cbx_item_itemquantity_delivery_cbxitem_itemquantity_countrycode STRING(250),
cbx_item_itemquantity_delivery_cbxitem_itemquantity_delivery_deliverynumber STRING(250),
src_item_doc_ref STRING(40),
client_id_order BIGNUMERIC(38),
country_del_seq_nr BIGNUMERIC(38),
cy_week_delivery BIGNUMERIC(38),
country_request_qty BIGNUMERIC(38),
country_delivery_qty BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);