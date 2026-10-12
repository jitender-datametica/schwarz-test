CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_packingmethod_assortment_assortsize_2_mdm_item_packing_list_pos_hist
(
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_pack_list_sid BIGNUMERIC(38),
mdm_item_set_sid BIGNUMERIC(38),
mdm_item_size_sid BIGNUMERIC(38),
pack_list_pos_version BIGNUMERIC(38),
pack_list_pos_priority BIGNUMERIC(38),
pack_list_pos_req_qty BIGNUMERIC(38),
pack_list_pos_pack_qty BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);