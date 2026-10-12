CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_packingmethod_assortment_assortsize_2_mdm_item_packing_list_pos_hist
(
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_packingmethod_assortment_assortsize_cbxitem_documentref STRING(250),
cbx_item_packingmethod_assortment_assortsize_cbxitem_packingmethod_code STRING(250),
cbx_item_packingmethod_assortment_assortsize_cbxitem_packingmethod_assortment_itemstyleuniqueids STRING(2000),
cbx_item_packingmethod_assortment_assortsize_cbxitem_packingmethod_assortment_assortsize_itemsize_code STRING(400),
src_item_doc_ref STRING(400),
src_pack_method_cd STRING(400),
src_style_uniqids_cd STRING(2000),
src_size_cd STRING(400),
pack_list_pos_version BIGNUMERIC(38),
pack_list_pos_priority BIGNUMERIC(38),
pack_list_pos_req_qty BIGNUMERIC(38),
pack_list_pos_pack_qty BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);