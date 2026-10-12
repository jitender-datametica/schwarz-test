CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_packingmethod_2_mdm_item_packing_list_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_packingmethod_cbxitem_documentref STRING(250),
cbx_item_packingmethod_cbxitem_packingmethod_code STRING(250),
src_item_doc_ref STRING(40),
src_pack_method_cd STRING(40),
pack_list_version BIGNUMERIC(38),
pack_list_name STRING(100) COLLATE 'und:ci',
pack_list_carton_qty BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);